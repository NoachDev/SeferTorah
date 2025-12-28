import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sefertorah/providers/graph_providers.dart';
import 'package:sefertorah/providers/books_hub.dart';
import 'package:sefertorah/util.dart';
import 'package:sefertorah/widgets/home/panel_button.dart';

interface class Forces {
  double betweenVertexes = 10.0;
  double centerExpand = 1.0;
  double edgeLenght = 100.0;
  double centerContract = 0.001;
}

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

/// The normal MapConvertor, but change [solid], [scaleDegree], [radiusScale]
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
  final Options options;
  final Forces forces;
  const GraphView({
    super.key,
    this.data,
    required this.options,
    required this.forces,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterGraphWidget(
      data: data,
      // todo : generate a new vertex below of the father
      algorithm: ForceDirected(
        decorators: [
          HookeBorderDecorator(borderFactor: 0.8, k: 10, alwaysInScreen: true),
          CoulombDecorator(k: forces.betweenVertexes),
          CoulombCenterDecorator(k: forces.centerExpand),
          HookeDecorator(length: forces.edgeLenght),
          HookeCenterDecorator(k: forces.centerContract),
          ForceDecorator(),
          ForceMotionDecorator(),
          TimeCounterDecorator(),
        ],
      ),
      convertor: CustomConvertor(),
      options: options
        ..scale.value = 0.6
        ..enableHit = true
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

class Hub extends ConsumerWidget {
  final myOption = Options();

  final Map<String, List<dynamic>> data = {"vertexes": [], "edges": []};
  final Map<String, Set> childrenCache = {};
  final Forces forces;

  Hub({super.key, required this.forces});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasOpened = -MediaQuery.of(context).size.height / 5;

    final vertexes = ref.watch(getVertexes(null));
    final edges = ref.watch(getEdges);

    final isLoading = vertexes.isLoading || edges.isLoading;
    final error = vertexes.error ?? edges.error;

    List vertexesInCache(String id) {
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
    void rmChildren(String id) {
      myOption.graph.disjoinGraph({
        "vertexes": vertexesInCache(id),
        "edges": [],
      });
    }

    void addChildren(String id) async {
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
        myOption.offset.value = Offset(0, canvasOpened);
        myOption.scale.value = min(myOption.scale.value, 0.5);
      }

      ref.read(booksProvider.notifier).setBooks(books, id);

      myOption.graph.mergeGraph({"vertexes": vertexes, "edges": edges});
    }

    myOption.onVertexTapUp = (vertex, event) {
      if (vertex.picked) {
        rmChildren(vertex.id);
        vertex.picked = false;
        return;
      }

      addChildren(vertex.id);
      vertex.picked = true;
    };

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
            options: myOption,
            forces: forces,
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
  }
}

class Panel extends StatefulWidget {
  final Forces forces = Forces();

  Panel({super.key});

  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  bool opened = false;
  bool animationInProgress = false;

  final sliderPadding = const EdgeInsets.only(
    top: 2.0,
    bottom: 6.0,
    left: 25,
    right: 25,
  );

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: opened ? 10 : 0,
      top: MediaQuery.of(context).size.height / 6.5,
      child: TapRegion(
        onTapOutside: (details) {
          if (opened) {
            setState(() {
              opened = false;
              animationInProgress = true;
            });
          }
        },
        onTapInside: (event) {
          if (!opened) {
            setState(() {
              opened = true;
              animationInProgress = true;
            });
          }
        },
        child: AnimatedContainer(
          onEnd: () {
            setState(() {
              animationInProgress = false;
            });
          },
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: opened
                ? BorderRadius.circular(12)
                : const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
            color: opened
                ? Theme.of(context).colorScheme.tertiary
                : Colors.white,
          ),
          height: opened ? 500 : 125,
          width: opened ? 270 : 13,
          child: opened
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text("Forças", style: TextStyle(fontSize: 16)),
                      ),
                      const Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 35),
                          child: Text("Entre vertices"),
                        ),
                      ),
                      Slider(
                        value: widget.forces.betweenVertexes,
                        padding: sliderPadding,
                        min: 0,
                        max: 100,
                        onChanged: (value) => {
                          setState(() {
                            widget.forces.betweenVertexes = value;
                          }),
                        },
                      ),
                      const Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 35),
                          child: Text("Centrifuga"),
                        ),
                      ),
                      Slider(
                        value: widget.forces.centerExpand,
                        padding: sliderPadding,
                        min: 0,
                        max: 100,
                        onChanged: (value) => {
                          setState(() {
                            widget.forces.centerExpand = value;
                          }),
                        },
                      ),
                      const Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 35),
                          child: Text("Centripeta"),
                        ),
                      ),
                      Slider(
                        value: widget.forces.centerContract,
                        padding: sliderPadding,
                        min: 0,
                        max: 100,
                        onChanged: (value) => {
                          setState(() {
                            widget.forces.centerContract = value;
                          }),
                        },
                      ),
                      const Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 35),
                          child: Text("Tamanho das arestas"),
                        ),
                      ),
                      Slider(
                        value: widget.forces.edgeLenght,
                        padding: sliderPadding,
                        min: 0,
                        max: 100,
                        onChanged: (value) => {
                          setState(() {
                            widget.forces.edgeLenght = value;
                          }),
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          spacing: 5,
                          children: [
                            const PanelButton(
                              title: "Sua conta",
                              trailing: "google",
                              leading: Icon(Icons.admin_panel_settings_sharp),
                              edgePosition: Alignment.topCenter,
                            ),
                            const PanelButton(
                              title: "Idioma",
                              trailing: "portugues",
                              leading: Icon(Icons.language),
                            ),
                            PanelButton(
                              title: "Repositorio",
                              trailing: "portugues",
                              onTap: launchRepo,
                              leading: SvgPicture.asset(
                                'assets/icons/git.svg',
                                semanticsLabel: 'calendar widget',
                                height: 20,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            Row(
                              spacing: 5,
                              children: [
                                const Flexible(
                                  child: PanelButton(
                                    title: "config",
                                    leading: Icon(Icons.settings),
                                    edgePosition: Alignment.bottomLeft,
                                  ),
                                ),
                                const Flexible(
                                  child: PanelButton(
                                    title: "ajuda",
                                    leading: Icon(Icons.help),
                                    edgePosition: Alignment.bottomLeft,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    /// TODO : Made the sliders in panel change the forces in Graph by graph.algorithm.decorators.[propiety]
    final myPanel = Panel();

    return GradientBackground(
      child: Stack(
        children: [
          Hub(forces: myPanel.forces),
          myPanel,
        ],
      ),
    );
  }
}
