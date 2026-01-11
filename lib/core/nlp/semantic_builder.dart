import 'package:sefertorah/core/isar/lexical_sense.dart';
import 'package:sefertorah/core/models/dictionaries.dart';
import 'package:sefertorah/core/nlp/dsl.dart';
import 'package:sefertorah/core/nlp/syntax_builder.dart';

typedef SemanticRole = String; // "agent", "theme", "recipient", "location"

abstract class SemanticNode {
  final int id; // interno do grafo
  final LexicalSense sense;
  final MorphologicalCategory? morphology; // Vital para tradução (tempo, gênero, número)

  SemanticNode(this.id, this.sense, {this.morphology});

  @override
  String toString() => '$runtimeType($id, ${sense.lemmaPt}, ${morphology?.category.name})';
}

class SemanticEvent extends SemanticNode {
  SemanticEvent(super.id, super.sense, {super.morphology});
}

class SemanticEntity extends SemanticNode {
  SemanticEntity(super.id, super.sense, {super.morphology});
}

class SemanticProperty extends SemanticNode {
  SemanticProperty(super.id, super.sense, {super.morphology});
}

class SemanticEdge {
  final SemanticNode from; // geralmente evento
  final SemanticNode to;   // entidade ou evento
  final SemanticRole role;
  final double confidence;

  SemanticEdge({
    required this.from,
    required this.to,
    required this.role,
    required this.confidence,
  });

  @override
  String toString() => '${from.id} --$role--> ${to.id}';
}

class SemanticGraph {
  final Map<int, SemanticNode> nodes = {};
  final List<SemanticEdge> edges = [];

  void addNode(SemanticNode node) {
    nodes[node.id] = node;
  }

  void addEdge(SemanticEdge edge) {
    edges.add(edge);
  }

  @override
  String toString() => 'Nodes: ${nodes.length}, Edges: ${edges.length}';
}

class SemanticBuilder {
  final graph = SemanticGraph();
  final _morphClassifier = MorphProjection();

  void build(ParseState state, List<LexicalSense> senses) {
    // 1. Construção dos Nós (Nodes)
    for (final node in state.nodes) {
      // O LexicalSense vem da lista externa (alinhada por índice)
      final sense = senses[node.tokenIndex];
      
      // A Morfologia vem da projeção sintática escolhida no ParseState
      // Isso utiliza a DSL (dsl.dart) para classificar a Signature bruta
      final signature = node.projection.source;
      final morphology = _morphClassifier.classify(signature);

      late SemanticNode semanticNode;

      switch (sense.type){
        case SemanticType.event : 
          semanticNode = SemanticEvent(node.tokenIndex, sense, morphology: morphology);
        case SemanticType.property : 
          semanticNode = SemanticProperty(node.tokenIndex, sense, morphology: morphology);
        default : 
          semanticNode = SemanticEntity(node.tokenIndex, sense, morphology: morphology);
      }
      
      graph.addNode(semanticNode);
    }

    // 2. Construção das Arestas (Edges) baseada nas Relações Sintáticas
    for (final rel in state.relations) {
      // Na sintaxe: From = Head (ex: Verbo), To = Dependent (ex: Sujeito)
      final headSense = senses[rel.from.tokenIndex];
      
      // Filtra apenas relações onde o núcleo é um Evento (Verbo) ou modificadores relevantes
      if (headSense.type != SemanticType.event && rel.kind != RelationKind.modifier) continue;

      final headId = rel.from.tokenIndex;
      final depId = rel.to.tokenIndex;

      final role = _inferRole(rel.kind);

      if (role != null) {
        graph.addEdge(
          SemanticEdge(
            from: graph.nodes[headId]!,
            to: graph.nodes[depId]!,
            role: role,
            confidence: 0.8,
          ),
        );
      }
    }
    
    // 3. (Futuro) Tratamento de Elipses / Sujeitos Ocultos aqui
  }

  SemanticRole? _inferRole(RelationKind kind) {
    switch (kind) {
      case RelationKind.subject:
        return "agent";
      case RelationKind.object:
        return "theme";
      case RelationKind.indirectObject:
        return "recipient";
      case RelationKind.modifier:
        return "modifier";
      case RelationKind.complement:
        return "possessor"; // Smikhut
      default:
        return null;
    }
  }
}