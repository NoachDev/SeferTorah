import 'package:sefertorah/core/isar/lexical_sense.dart';
import 'package:sefertorah/core/models/dictionaries.dart';
import 'package:sefertorah/core/nlp/dsl.dart';
import 'package:sefertorah/core/nlp/syntax_builder.dart';

typedef SemanticRole = String; // "agent", "theme", "recipient", "location"

abstract class SemanticNode {
  final int id; // interno do grafo
  final LexicalSense sense;
  final MorphologicalCategory? morphology;

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
  final SemanticNode from; 
  final SemanticNode to;
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
  final SemanticGraph graph ;

  SemanticBuilder(this.graph);

  factory SemanticBuilder.build(ParseState state, List<LexicalSense?> senses) {
    SemanticRole? inferRole(RelationKind kind) {
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

    final morphClassifier = MorphProjection();
    final graph = SemanticGraph();

    for (final node in state.nodes) {
      final sense = senses[node.tokenIndex];
      
      final signature = node.projection.source;
      final morphology = morphClassifier.classify(signature);

      switch (sense?.type){
        case SemanticType.event : 
          graph.addNode(  SemanticEvent(node.tokenIndex, sense!, morphology: morphology) );
        case SemanticType.property : 
          graph.addNode(  SemanticProperty(node.tokenIndex, sense!, morphology: morphology));
        case SemanticType.entity : 
          graph.addNode( SemanticEntity(node.tokenIndex, sense!, morphology: morphology));
        default : null;
      }
      
    }

    for (final rel in state.relations) {
      // In the syntax: From = Head (ex: Verb), To = Dependent (ex: Subject)
      final headSense = senses[rel.from.tokenIndex];
      
      // Filters only relationships where the nucleus is an Event (Verb) or relevant modifiers
      if (headSense!.type != SemanticType.event && rel.kind != RelationKind.modifier) continue;

      final headId = rel.from.tokenIndex;
      final depId = rel.to.tokenIndex;

      final role = inferRole(rel.kind);

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
    
    /// TODO : Treatment of Ellipses / Hidden Subjects here
    /// 
    
    return SemanticBuilder(graph);

  }

  
}