import 'package:sefertorah/core/isar/dictionaries.dart';
import 'package:sefertorah/core/models/dictionaries.dart';
import 'dart:math';

enum RelationKind {
  subject,
  object,
  indirectObject,
  modifier,
  complement,
  predicate,
  connector,
}

enum SyntacticCategory { nominal, verbal, modifier, connector }

enum ProjectionStrength {
  strong,
  weak,
  hybrid, // ref + pred
}

enum ArgumentSlot { subject, object, indirectObject, complement }

class SyntacticProjection {
  final SyntacticCategory category;

  final ProjectionStrength strength;

  final bool canProject;

  final bool canModify;

  final bool canPredicate;

  final Set<ArgumentSlot> argumentSlots;

  final bool requiresComplement;

  final double prior;

  final Signature source;

  SyntacticProjection({
    required this.category,
    required this.strength,
    required this.canProject,
    required this.canModify,
    required this.canPredicate,
    required this.argumentSlots,
    required this.requiresComplement,
    required this.source,
    this.prior = 1,
  });

  factory SyntacticProjection.create(Signature sign) {
    final cat = sign.categoricalTraits;

    final bool isRef = cat[0] == 1;
    final bool isPred = cat[1] == 1;
    final bool isMod = cat[2] == 1;

    SyntacticCategory category;
    if (isPred) {
      category = SyntacticCategory.verbal;
    } else if (isRef) {
      category = SyntacticCategory.nominal;
    } else if (isMod) {
      category = SyntacticCategory.modifier;
    } else {
      category = SyntacticCategory.connector;
    }

    ProjectionStrength strength;
    if (isRef && isPred) {
      strength = ProjectionStrength.hybrid;
    } else if (isMod) {
      strength = ProjectionStrength.weak;
    } else {
      strength = ProjectionStrength.strong;
    }

    final argumentSlots = <ArgumentSlot>{};

    if (isPred) {
      argumentSlots.add(ArgumentSlot.subject);
      argumentSlots.add(ArgumentSlot.object);
    }

    if (sign.abstractLexicalTraits?.grammaticalState ==
        GrammaticalState.construct) {
      argumentSlots.add(ArgumentSlot.complement);
    }

    return SyntacticProjection(
      category: category,
      strength: strength,
      canProject: isRef || isPred,
      canModify: isMod,
      canPredicate: isPred,
      argumentSlots: argumentSlots,
      requiresComplement:
          sign.abstractLexicalTraits?.grammaticalState ==
          GrammaticalState.construct,
      source: sign,
    );
  }
}

class SyntaxNode {
  final int tokenIndex;
  final SyntacticProjection projection;

  SyntaxNode(this.tokenIndex, this.projection);

  @override
  String toString() => 'Node($tokenIndex, ${projection.category.name})';
}

class SyntaxRelation {
  final SyntaxNode from;
  final SyntaxNode to;
  final RelationKind kind;

  SyntaxRelation({required this.from, required this.to, required this.kind});

  @override
  String toString() {
    return '${from.tokenIndex} --${kind.name}--> ${to.tokenIndex}';
  }

  @override
  bool operator ==(Object other) {
    return super.toString() == other.toString();
  }
}

class ParseState {
  final List<SyntaxNode> nodes;
  final List<SyntaxRelation> relations;
  final double score;

  ParseState({
    required this.nodes,
    required this.relations,
    required this.score,
  });

  bool hasHead(SyntaxNode node) {
    return relations.any((r) => r.to == node);
  }

  bool hasRelation(SyntaxNode head, RelationKind kind) {
    return relations.any((r) => r.to == head && r.kind == kind);
  }

  List<SyntaxRelation> previousByRelations(dynamic target) {
    List<SyntaxRelation> ret = relations
        .where(
          (elm) =>
              elm.to.tokenIndex == target.tokenIndex &&
              elm.from.tokenIndex < target.tokenIndex,
        )
        .toList();

    List<SyntaxRelation> newNodes = [];

    for (final i in ret) {
      newNodes.addAll(previousByRelations(i.from));
    }

    return [...ret, ...newNodes];
  }

  List<SyntaxRelation> afterByRelations(dynamic target) {
    List<SyntaxRelation> ret = relations
        .where((elm) => elm.to.tokenIndex == target.tokenIndex)
        .toList();

    List<SyntaxRelation> newNodes = [];

    for (final i in ret) {
      newNodes.addAll(afterByRelations(i.from));
    }

    return [...ret, ...newNodes];
  }

  ParseState copyWith({
    List<SyntaxNode>? nodes,
    List<SyntaxRelation>? relations,
    double? score,
  }) {
    return ParseState(
      nodes: [...this.nodes, ...nodes ?? []],
      relations: [...this.relations, ...relations ?? []],
      score: score ?? this.score,
    );
  }

  List<String> toListString() {
    List<String> ret = nodes
        .map(
          (node) =>
              "Node(${node.tokenIndex})->${relations.where((val) => val.from == node).map((elm) => "${elm.kind.name}->Node(${elm.to.tokenIndex})").toList()}",
        )
        .toList();

    return ret;
  }
}

class SyntaxToken {
  final int index;
  final String surface;
  final List<SyntacticProjection> projections;

  SyntaxToken({
    required this.index,
    required this.surface,
    required this.projections,
  });
}

class SyntaxBuilder {
  final int beamWidth;
  List<ParseState> hypotheses = [];

  SyntaxBuilder({this.beamWidth = 5});

  /// Create the hypotheses maintaining the ambiguity by sates
  ///
  /// for all [SyntaxToken] in [tokens], get the projections in him and create a node from them,
  /// this nodes will added in all preview sates
  /// after that, try attach this nodes with others in each state,
  /// the betters sates will alive, the others cuted by [_prune]
  ///
  void build(List<SyntaxToken> tokens) {
    var currentStates = [ParseState(nodes: [], relations: [], score: 0.0)];

    for (final token in tokens) {
      final nextStates = <ParseState>[];

      for (final state in currentStates) {
        for (final proj in token.projections) {
          final newNode = SyntaxNode(token.index, proj);

          // Base state with new node added
          final baseState = state.copyWith(nodes: [newNode]);

          // Option 0: No attachment (isolated node)
          nextStates.add(baseState.copyWith(score: baseState.score - 0.1));

          final possibleAttachments = <ParseState>[];

          // Try attaching new node to existing nodes
          for (final existingNode in state.nodes) {
            // Direction 1: Existing (Head) -> New (Dependent)
            _tryAttachToBack(
              possibleAttachments.lastOrNull ?? baseState,
              existingNode,
              newNode,
              possibleAttachments,
            );

            // Direction 2: New (Head) -> Existing (Dependent)
            _tryAttachFrom(
              possibleAttachments.lastOrNull ?? baseState,
              newNode,
              existingNode,
              possibleAttachments,
            );
          }

          nextStates.addAll(possibleAttachments);
        }
      }

      currentStates = _pruneList(nextStates);
    }

    hypotheses = currentStates;
  }

  void _tryAttachToBack(
    ParseState state,
    SyntaxNode head,
    SyntaxNode dependent,
    List<ParseState> outStates,
  ) {
    // Tree constraint: a node usually has only one head
    // if (state.hasHead(dependent)) return;

    final headProj = head.projection;
    final depProj = dependent.projection;
    final distance = (head.tokenIndex - dependent.tokenIndex).abs();

    RelationKind? kind;
    double scoreBonus = 0.0;

    // 1. Connector
    if (headProj.category == SyntacticCategory.connector && distance == 1) {
      kind = RelationKind.connector;
      scoreBonus += 1;
    }
    // 2. Modifiers
    else if (headProj.canModify && depProj.canProject && distance == 1) {
      kind = RelationKind.modifier;
      scoreBonus += 1.0 / distance;
    } else if (headProj.canModify &&
        depProj.category == SyntacticCategory.connector &&
        distance == 1) {
      kind = RelationKind.modifier;
      scoreBonus += 2;
    }

    if (kind != null) {
      double distancePenalty = log(distance) * 0.1;
      outStates.add(
        state.copyWith(
          relations: [SyntaxRelation(from: head, to: dependent, kind: kind)],
          score:
              state.score +
              headProj.prior +
              depProj.prior +
              scoreBonus -
              distancePenalty,
        ),
      );
    }
  }

  void _tryAttachFrom(
    ParseState state,
    SyntaxNode head,
    SyntaxNode dependent,
    List<ParseState> outStates,
  ) {
    final headProj = head.projection;
    final depProj = dependent.projection;
    final distance = (head.tokenIndex - dependent.tokenIndex).abs();

    RelationKind? kind;
    double scoreBonus = 0.0;

    // 1. Predicates
    if (depProj.canPredicate) {
      // Subject
      if (headProj.category == SyntacticCategory.nominal &&
          depProj.argumentSlots.contains(ArgumentSlot.subject) &&
          !state.hasRelation(dependent, RelationKind.subject)) {
        kind = RelationKind.subject;
        // VSO preference
        scoreBonus += 1.0;
        // if (dependent.tokenIndex > head.tokenIndex && distance == 1) {}
      }
      // Object
      else if (headProj.category == SyntacticCategory.nominal &&
          depProj.argumentSlots.contains(ArgumentSlot.object) &&
          state.hasRelation(
            dependent,
            RelationKind.subject,
          ) && // Prefer finding subject first? Not strictly necessary but helps structure
          !state.hasRelation(dependent, RelationKind.object)) {
        kind = RelationKind.object;
        scoreBonus += 0.5;
      }
    }
    // 2. Smikhut (Construct Chain)
    // Must be adjacent: Head (Construct) -> Dependent (Genitive
    else if (depProj.requiresComplement &&
        head.tokenIndex > dependent.tokenIndex &&
        // distance == 1 &&
        depProj.category == SyntacticCategory.nominal &&
        headProj.category != SyntacticCategory.modifier &&
        headProj.category != SyntacticCategory.connector) {
      kind = RelationKind.complement;
      scoreBonus += 2.0;
    }

    if (kind != null) {
      double distancePenalty = log(distance) * 0.1;
      outStates.add(
        state.copyWith(
          relations: [SyntaxRelation(from: head, to: dependent, kind: kind)],
          score:
              state.score +
              headProj.prior +
              depProj.prior +
              scoreBonus -
              distancePenalty,
        ),
      );
    }
  }

  List<ParseState> _pruneList(List<ParseState> states) {
    states.sort((a, b) => b.score.compareTo(a.score));
    return states.take(beamWidth).toList();
    // return states;
  }
}
