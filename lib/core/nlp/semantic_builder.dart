import 'package:sefertorah/core/isar/lexical_sense.dart';
import 'package:sefertorah/core/models/dictionaries.dart';
import 'package:sefertorah/core/nlp/dsl.dart';
import 'package:sefertorah/core/nlp/syntax_builder.dart';

// typedef SemanticRole = String; // "agent", "theme", "recipient", "location"

enum SemanticRole {
  agent,
  theme,
  recipient,
  // location,
  possessor,
  modifier,
} // "agent", "theme", "recipient", "location"

abstract class SemanticNode {
  final int tokenIndex;
  final LexicalSense sense;
  final MorphologicalCategory? morphology;
  final SyntaxNode? socket;

  SemanticNode(this.tokenIndex, this.sense, {this.morphology, this.socket});

  @override
  String toString() =>
      '$runtimeType($tokenIndex, ${sense.lemmaPt}, ${morphology?.category.name})';
}

class SemanticEvent extends SemanticNode {
  SemanticEvent(super.id, super.sense, {super.morphology, super.socket});
}

class SemanticEntity extends SemanticNode {
  SemanticEntity(super.id, super.sense, {super.morphology, super.socket});
}

class SemanticProperty extends SemanticNode {
  SemanticProperty(super.id, super.sense, {super.morphology, super.socket});
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
  String toString() => '${from.tokenIndex} --$role--> ${to.tokenIndex}';
}

class SemanticGraph {
  final Map<int, dynamic> nodes = {};
  final List<SemanticEdge> edges = [];
  final List<Bucket> buckets = [Bucket()];

  void addNode(SemanticNode node) {
    nodes[node.tokenIndex] = node;
  }

  void addEdge(SemanticEdge edge) {
    edges.add(edge);
  }

  @override
  String toString() => 'Nodes: ${nodes.length}, Edges: ${edges.length}';
}

class Bucket {
  SemanticEntity? agent;
  SemanticEvent? theme;
  List<SemanticNode> recipient = [];
  List<SemanticProperty> modifier = []; // adjectives and others of kind
  // SemanticNode? possessor;

  Bucket();

  @override
  String toString() {
    final ret = StringBuffer();
    ret.write("-------Buket-------\n");
    ret.write("agent : ${agent?.sense.lemmaPt}\n");
    ret.write("theme : ${theme?.sense.lemmaPt}\n");
    for (var (index, elm) in recipient.indexed) {
      ret.write("recipient ${index + 1} : ${elm?.sense.lemmaPt}\n");
    }
    for (var (index, elm) in modifier.indexed) {
      ret.write("modifier ${index + 1} : ${elm.sense.lemmaPt}\n");
    }
    ret.write("--------end--------");

    return ret.toString();
  }
}

class LinearEntity {
  final SemanticNode core;
  final String? decoration;

  LinearEntity(this.core, {this.decoration});

  @override
  String toString() {
    return "${decoration ?? ""} ${core.sense.lemmaPt}";
  }

  @override
  bool operator ==(Object other) {
    return core == other;
  }
}

class SemanticBuilder {
  final SemanticGraph graph = SemanticGraph();
  final ParseState state;
  final List<LexicalSense?> senses;
  final _morphClassifier = MorphProjection();

  void _createNodes() {
    bool grammalacking = false;

    for (final node in state.nodes) {
      final sense = senses[node.tokenIndex];

      final signature = node.projection.source;
      final morphology = _morphClassifier.classify(signature);

      switch (sense?.type) {
        case SemanticType.event:
          SyntaxNode? socket;

          if (grammalacking) {
            socket = state.nodes[node.tokenIndex - 1];
            grammalacking = false;
          }

          graph.addNode(
            SemanticEvent(
              node.tokenIndex,
              sense!,
              morphology: morphology,
              socket: socket,
            ),
          );
          break;
        case SemanticType.property:
          graph.addNode(
            SemanticProperty(node.tokenIndex, sense!, morphology: morphology),
          );
          break;
        case SemanticType.entity:
          graph.addNode(
            SemanticEntity(node.tokenIndex, sense!, morphology: morphology),
          );
          break;
        case SemanticType.gramma:
          // graph.addNode(
          //   SemanticProperty(node.tokenIndex, sense!, morphology: morphology),
          // );
          grammalacking = true;
          break;
        default:
          break;
      }
    }
  }

  void _createBuckets() {
    for (final rel in state.relations) {
      switch (rel.kind) {
        case RelationKind.subject:
          if (graph.buckets.last.agent != null) {
            graph.buckets.add(Bucket());
          }
          graph.buckets.last.theme = graph.nodes[rel.to.tokenIndex];
          graph.buckets.last.agent = graph.nodes[rel.from.tokenIndex];
          break;
        case RelationKind.object:
          final node = graph.nodes[rel.to.tokenIndex]!;
          if (graph.buckets.last.theme != node) {
            graph.buckets.add(Bucket());
            graph.buckets.last.theme = node;
          } else {
            graph.buckets.last.recipient.add(graph.nodes[rel.from.tokenIndex]);
          }
          break;
        // case RelationKind.indirectObject:
        //   // if (graph.buckets.last.recipient != null) {
        //   //   graph.buckets.add(Bucket());
        //   // }
        //   // graph.buckets.last.recipient = graph.nodes[rel.from.tokenIndex]!;
        //   break;
        case RelationKind.complement:
          if (graph.buckets.last.recipient.isEmpty) {
            graph.buckets.add(Bucket());
          }
          graph.buckets.last.recipient.add(graph.nodes[rel.from.tokenIndex]);
          break;

        default:
          null;
      }
    }
  }

  List<LinearEntity> linearizationSVO({List<Function> decorations = const []}) {
    List<LinearEntity> ret = [];

    for (final bucket in graph.buckets) {
      // add decorations like artigues, prepositions or another of kind
      // decorations.forEach((elm) => elm(node.decoration));

      final agentPrevious = state.previousByRelations(bucket.theme!);
      agentPrevious.addAll(state.previousByRelations(bucket.agent!));
      final fap = agentPrevious
          .where((elm) => elm.kind != RelationKind.subject)
          .map((elm) => elm.from.tokenIndex)
          .toList();

      fap.sort((a, b) => a.compareTo(b));

      for (var elm in fap) {
        if (graph.nodes.containsKey(elm)) {
          ret.add(LinearEntity(graph.nodes[elm]!));
        }
      }

      ret.add(LinearEntity(bucket.agent!));

      // final agentAfter = state.afterByRelations(bucket.agent!);

      // final themePrevious = state.previousByRelations(bucket.theme!);

      // final ftp = themePrevious.where((elm) => elm.kind != RelationKind.subject && !fap.contains(elm.to.tokenIndex)).map((elm) => elm.to.tokenIndex).toList();

      // ftp.sort((a,b) => a.compareTo(b));

      // for (var elm in ftp) {
      //   if (graph.nodes.containsKey(elm)){
      //     ret.add(LinearEntity(graph.nodes[elm]!));
      //   }
      // }

      ret.add(LinearEntity(bucket.theme!));

      for (final elm in bucket.recipient) {
        final objectPrevious = state
            .previousByRelations(elm)
            .where((elm) => elm.kind != RelationKind.subject)
            .map((elm) => elm.from.tokenIndex)
            .toList();
        objectPrevious.sort((a, b) => a.compareTo(b));
        for (var elm in objectPrevious) {
          if (graph.nodes.containsKey(elm)) {
            ret.add(LinearEntity(graph.nodes[elm]!));
          }
        }

        ret.add(LinearEntity(elm));
      }
    }

    /// verify if did't lose any information
    assert(
      ret.length == graph.nodes.values.length,
      "The linearization builded a incomplete chain",
    );

    return ret;
  }

  SemanticBuilder(this.state, this.senses) {
    _createNodes();
    _createBuckets();

    /// TODO : Treatment of Ellipses / Hidden Subjects here
    ///
  }
}
