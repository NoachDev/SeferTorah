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
  strong, // núcleo claro
  weak, // dependente estrutural
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
    return relations.any((r) => r.from == head && r.kind == kind);
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

          // Try attaching new node to existing nodes
          for (final existingNode in state.nodes) {
            // Direction 1: Existing (Head) -> New (Dependent)
            _tryAttach(baseState, existingNode, newNode, nextStates);

            // Direction 2: New (Head) -> Existing (Dependent)
            _tryAttach(baseState, newNode, existingNode, nextStates);
          }
        }
      }
      currentStates = _pruneList(nextStates);
    }

    hypotheses = currentStates;
  }

  void _tryAttach(
    ParseState state,
    SyntaxNode head,
    SyntaxNode dependent,
    List<ParseState> outStates,
  ) {
    // Tree constraint: a node usually has only one head
    if (state.hasHead(dependent)) return;

    final headProj = head.projection;
    final depProj = dependent.projection;
    final distance = (head.tokenIndex - dependent.tokenIndex).abs();

    RelationKind? kind;
    double scoreBonus = 0.0;

    // 1. Connector
    if (depProj.category == SyntacticCategory.connector) {
      kind = RelationKind.connector;
    }

    // 2. Smikhut (Construct Chain)
    // Must be adjacent: Head (Construct) -> Dependent (Genitive)
    if (headProj.requiresComplement &&
        head.tokenIndex < dependent.tokenIndex &&
        distance == 1 &&
        depProj.category == SyntacticCategory.nominal) {
      kind = RelationKind.complement;
      scoreBonus += 2.0;
    }
    // 3. Predication
    else if (headProj.canPredicate) {
      // Subject
      if (depProj.category == SyntacticCategory.nominal &&
          headProj.argumentSlots.contains(ArgumentSlot.subject) &&
          !state.hasRelation(head, RelationKind.subject)) {
        kind = RelationKind.subject;
        // VSO preference
        if (dependent.tokenIndex > head.tokenIndex && distance == 1) {
          scoreBonus += 1.0;
        }
      }
      // Object
      else if (depProj.category == SyntacticCategory.nominal &&
          headProj.argumentSlots.contains(ArgumentSlot.object) &&
          state.hasRelation(
            head,
            RelationKind.subject,
          ) && // Prefer finding subject first? Not strictly necessary but helps structure
          !state.hasRelation(head, RelationKind.object)) {
        kind = RelationKind.object;
        if (dependent.tokenIndex > head.tokenIndex) scoreBonus += 0.9;
      }
    }
    // 4. Modifiers
    else if (depProj.canModify && headProj.canProject) {
      // Hebrew modifiers usually follow head
      if (head.tokenIndex < dependent.tokenIndex) {
        kind = RelationKind.modifier;
        scoreBonus += 1.0 / distance;
      } else if (head.tokenIndex > dependent.tokenIndex && distance == 1) {
        // Support for proclitics (Articles, Prepositions, etc) which precede the head
        kind = RelationKind.modifier;
        scoreBonus += 2.0; // Strong preference for adjacent prefixes
      }
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
  }
}
