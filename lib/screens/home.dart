import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sefertorah/providers/graph_providers.dart';
import 'package:sefertorah/providers/books_hub.dart';

class GradientBackground extends StatelessWidget {
  final Widget? child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final List<Color> defaultColors = [
      Theme.of(context).colorScheme.primary.withAlpha(53),
      const Color.fromARGB(0, 0, 0, 0),
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.6,
          colors: defaultColors,
        ),
      ),
      child: child,
    );
  }
}

class CustomConvertor extends MapConvertor {
  @override
  Edge convertEdge(Map<dynamic, dynamic> e, Graph<dynamic> g) {
    Edge result = Edge();
    result.ranking = e['ranking'];
    result.edgeName = e['edgeName'];
    result.solid = true;

    result.start = g.keyCache[e['srcId']]!;
    result.end = g.keyCache[e['dstId']];

    return result;
  }

  @override
  Vertex convertVertex(Map<dynamic, dynamic> v, Graph<dynamic> g) {
    Vertex vertex = Vertex();
    vertex.id = v['id'];
    vertex.tag = v['tag'];
    vertex.tags = v['tags'];
    vertex.data = v['data'];
    vertex.solid = true;
    vertex.radiusScale = 2.0;
    vertex.scaleDegree = false;
    return vertex;
  }
}

class GraphView extends StatelessWidget {
  final dynamic data;
  final dynamic Function(String) add;
  final dynamic Function(String) remove;
  final Options options;
  const GraphView({
    super.key,
    this.data,
    required this.options,
    required this.add,
    required this.remove,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterGraphWidget(
      data: data,
      // todo : generate a new vertex below of the father
      algorithm: ForceDirected(
        decorators: [
          HookeBorderDecorator(borderFactor: 0.8, k: 10, alwaysInScreen: true),
          CoulombDecorator(),
          CoulombCenterDecorator(k: 1),
          HookeDecorator(length: 100),
          HookeCenterDecorator(k: 0.001),
          ForceDecorator(),
          ForceMotionDecorator(),
          TimeCounterDecorator(),
        ],
      ),
      convertor: CustomConvertor(),
      options: options
        ..scale.value = 0.6
        ..enableHit = true
        ..onVertexTapUp = (vertex, event) {
          if (vertex.picked) {
            remove(vertex.id);
            vertex.picked = false;
            return;
          }

          add(vertex.id);
          vertex.picked = true;
        }
        ..graphStyle = (GraphStyle()
          ..tagColor = {
            "index0": Colors.grey.shade600,
            "index1": Colors.blue.shade200,
            "index2": Colors.red.shade200,
            "index3": Colors.purple.shade200,
            "index4": Colors.green.shade200,
            "index5": Colors.amber.shade200,
            "index6": Colors.deepOrange.shade200,
            "index7": Colors.pink.shade200,
            "index8": Colors.deepPurple.shade200,
            "index9": Colors.yellow.shade200,
            "index10": Colors.cyan.shade200,
            "index11": Colors.indigo.shade200,
          }
          ..vertexTextStyleGetter = (vertex, shape) {
            return TextStyle(color: Colors.white);
          })
        ..backgroundBuilder = (context) => Container(color: Colors.transparent),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Stack(
        children: [
          Consumer(
            builder: (contexts, ref, child) {
              final Map<String, List<dynamic>> data = {
                "vertexes": [],
                "edges": [],
              };
              final cnavasOpened = -MediaQuery.of(context).size.height / 5;

              final Map<String, Set> childrenCache = {};

              final vertexes = ref.watch(getVertexes(null));
              final edges = ref.watch(getEdges);

              final isLoading = vertexes.isLoading || edges.isLoading;
              final error = vertexes.error ?? edges.error;
              final myOption = Options();

              /// get all subtree from a vertex
              vertexesInCache(String id) {
                var vertexes = childrenCache.containsKey(id)
                    ? childrenCache[id]!.toList()
                    : [];

                if (vertexes.isNotEmpty) {
                  var others = [];

                  if (vertexes.first?["tags"].contains("index0")) {
                    ref.read(booksProvider.notifier).resetBooks();
                  }

                  for (var element in vertexes) {
                    others.addAll(vertexesInCache(element["id"]));
                  }

                  vertexes.addAll(others);
                }

                return vertexes;
              }

              /// function extend from Graph for remove all subtree from a vertcies
              rmChildren(String id) {
                myOption.graph.disjoinGraph({
                  "vertexes": vertexesInCache(id),
                  "edges": [],
                });
              }

              addChildren(String id) async {
                late List vertexes;

                if (childrenCache.containsKey(id)) {
                  vertexes = childrenCache[id]!.toList();
                } else {
                  vertexes = await ref.read(getVertexes(id).future);
                  childrenCache[id] = Set.identity();
                }

                List<Map> edges = [];
                Map<String, dynamic> books = {};

                for (var element in vertexes) {
                  edges.add({
                    "srcId": id,
                    "dstId": element["id"],
                    "ranking": 1,
                    "edgeName": "chldrenConnection",
                  });

                  childrenCache[id]!.add(element);
                  if (element["tags"].contains("index0")) {
                    books.addAll({element["id"]: null});
                  }
                }

                // remove another subgraphs of have childrens with tags index0
                if (ref.read(booksProvider.notifier).showbooks) {
                  rmChildren(ref.read(booksProvider.notifier).collectionId!);
                }

                if (books.isNotEmpty) {
                  // TODO : need be animated
                  myOption.offset.value = Offset(0, cnavasOpened);
                  myOption.scale.value = min(myOption.scale.value, 0.5);
                }

                ref.read(booksProvider.notifier).setBooks(books, id);

                myOption.graph.mergeGraph({
                  "vertexes": vertexes,
                  "edges": edges,
                });
              }

              return Stack(
                children: [
                  if (isLoading)
                    const Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SafeArea(child: LinearProgressIndicator()),
                    ),
                  if (error == null)
                    GraphView(
                      data: data
                        ..["vertexes"]?.addAll(vertexes.value ?? [])
                        ..["edges"]?.addAll(edges.value ?? []),
                      add: addChildren,
                      remove: rmChildren,
                      options: myOption,
                    )
                  else
                    Center(
                      child: SizedBox(
                        width: 300,
                        child: Text(
                          "an error occurred : $error",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}