import 'package:sefertorah/core/models/dictionaries.dart';
import 'package:sefertorah/core/nlp/dsl.dart';

enum RelationKind { head, dependent, modifier }

class SyntacticProjection {
  final MorphReading reading;

  // Capacidades estruturais
  final bool canHead; // pode ser núcleo de uma frase
  final bool canTakeArgs; // pode receber dependentes
  final bool canBeArg; // pode ser argumento
  final bool canModify; // pode modificar outro nó
  final bool isFunctional; // partícula / conector

  // Preferências posicionais (viés, não regra)
  final bool prefersLeft; // tende a se ligar à esquerda
  final bool prefersRight; // tende a se ligar à direita

  // Peso inicial (heurístico ou aprendido depois)
  final double prior;

  SyntacticProjection({
    required this.reading,
    required this.canHead,
    required this.canTakeArgs,
    required this.canBeArg,
    required this.canModify,
    required this.isFunctional,
    required this.prefersLeft,
    required this.prefersRight,
    required this.prior,
  });

  factory SyntacticProjection.fromMorphReading(MorphReading reading) {
    bool determineCanHead(String morphClass) {
      // Verbos (predicadores) e Substantivos são núcleos de sintagmas (verbal/nominal).
      // Acessar context.cat[1] (pred) seria uma forma de fazer isso sem depender da string.
      return morphClass.contains('Verbo') || morphClass.contains('Substantivo');
    }

    bool determineCanTakeArgs(String morphClass, MorphContext context) {
      // Verbos podem ter objetos, e substantivos no estado construto exigem um dependente.
      return morphClass.contains('Verbo') ||
          context.state == GrammaticalState.construct;
    }

    bool determineCanBeArg(String morphClass) {
      // Substantivos e Pronomes são os argumentos canônicos de um predicado.
      return morphClass.contains('Substantivo') ||
          morphClass.contains('Pronome');
    }

    bool determineCanModify(String morphClass) {
      // Adjetivos são os modificadores por excelência.
      // context.cat[2] (mod) também poderia ser usado aqui.
      return morphClass.contains('Adjetivo') || morphClass.contains('Advérbio');
    }

    bool determineIsFunctional(String morphClass) {
      // Partículas, Conjunções, Preposições e Artigos são funcionais.
      return morphClass.contains('Partícula') ||
          morphClass.contains('Conjuncao') ||
          morphClass.contains('Preposicao') ||
          morphClass.contains('Artigo');
    }

    return SyntacticProjection(
      reading: reading,
      canHead: determineCanHead(reading.morphClass),
      canTakeArgs: determineCanTakeArgs(reading.morphClass, reading.ctx),
      canBeArg: determineCanBeArg(reading.morphClass),
      canModify: determineCanModify(reading.morphClass),
      isFunctional: determineIsFunctional(reading.morphClass),
      prefersLeft: false,
      prefersRight: reading.ctx.state == GrammaticalState.construct,
      prior: 1,
    );
  }

  toString() {
    return "Projection( canHead: $canHead, canTakeArgs: $canTakeArgs, canBeArg: $canBeArg, canModify: $canModify, isFunctional: $isFunctional, prefersLeft: $prefersLeft, prefersRight: $prefersRight, prior: $prior )";
  }
}

class SyntaxNode {
  final int tokenIndex; // posição linear
  final SyntacticProjection projection;

  SyntaxNode(this.tokenIndex, this.projection);
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

  ParseState copyWith({
    List<SyntaxNode>? nodes,
    List<SyntaxRelation>? relations,
    double? score,
  }) {
    return ParseState(
      nodes: nodes ?? this.nodes,
      relations: relations ?? this.relations,
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
  final int index; // posição linear
  // final String surface;
  final List<SyntacticProjection> projections;

  SyntaxToken({
    required this.index,
    // required this.surface,
    required this.projections,
  });
}

class SyntaxBuilder {
  final int beamWidth;

  SyntaxBuilder({this.beamWidth = 5});

  List<ParseState> build(List<SyntaxToken> tokens) {
    List<ParseState> states = [
      ParseState(nodes: [], relations: [], score: 0.0),
    ];

    for (final token in tokens) {
      states = _advance(states, token);
      states = _prune(states);
    }

    return states;
  }

  List<ParseState> _advance(List<ParseState> states, SyntaxToken token) {
    final List<ParseState> newStates = [];

    for (final state in states) {
      for (final proj in token.projections) {
        final node = SyntaxNode(token.index, proj);

        // Opção 1: nó isolado (ainda sem ligação)
        newStates.add(
          state.copyWith(
            nodes: [...state.nodes, node],
            score: state.score + proj.prior,
          ),
        );

        // Opção 2: tentar anexar a nós existentes
        for (final other in state.nodes) {
          _tryAttach(state, node, other, newStates);
        }
      }
    }

    return newStates;
  }

  bool _hasHead(ParseState state, SyntaxNode node) {
    return state.relations.any(
      (r) => r.from == node && r.kind == RelationKind.dependent,
    );
  }

  void _tryAttach(
    ParseState state,
    SyntaxNode node,
    SyntaxNode other,
    List<ParseState> out,
  ) {
    final proj = node.projection;
    final otherProj = other.projection;

    if (proj.canBeArg && otherProj.canTakeArgs) {
      out.add(
        state.copyWith(
          nodes: [...state.nodes, node],
          relations: [
            ...state.relations,
            SyntaxRelation(from: node, to: other, kind: RelationKind.dependent),
          ],
          score: state.score + _scoreAttachment(node, other),
        ),
      );
    }

    // node (Mod) -> other (Head)
    if (proj.canModify) {
      out.add(
        state.copyWith(
          nodes: [...state.nodes, node],
          relations: [
            ...state.relations,
            SyntaxRelation(from: node, to: other, kind: RelationKind.modifier),
          ],
          score: state.score + _scoreAttachment(node, other),
        ),
      );
    }

    if (otherProj.canBeArg && proj.canTakeArgs && !_hasHead(state, other)) {
      out.add(
        state.copyWith(
          nodes: [...state.nodes, node],
          relations: [
            ...state.relations,
            SyntaxRelation(from: other, to: node, kind: RelationKind.dependent),
          ],
          score: state.score + _scoreAttachment(other, node),
        ),
      );
    }

  }

  double _scoreAttachment(SyntaxNode a, SyntaxNode b) {
    double score = 0.0;

    if (a.tokenIndex < b.tokenIndex && a.projection.prefersRight) {
      score += 0.5;
    }

    if (a.tokenIndex > b.tokenIndex && a.projection.prefersLeft) {
      score += 0.5;
    }

    return score;
  }

  List<ParseState> _prune(List<ParseState> states) {
    states.sort((a, b) => b.score.compareTo(a.score));
    return states.take(beamWidth).toList();
  }
}
