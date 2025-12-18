import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sefertorah/graph_providers.dart';

class GradientBackground extends StatelessWidget {
  final Widget? child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final List<Color> defaultColors = [
      Theme.of(context).colorScheme.primary.withAlpha(53),
      const Color.fromARGB(0, 0, 0, 0)
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.6,
          colors: defaultColors
        ),
        
      ),
      child: child,
    );
  }
}

class Graph extends StatelessWidget {
  final dynamic data;
  const Graph({super.key, this.data});

  @override
  Widget build(BuildContext context) {

    return FlutterGraphWidget(
      data: data,
      algorithm: ForceDirected(decorators: [
          HookeBorderDecorator(borderFactor: 0.8, k : 1, alwaysInScreen: true),
          HookeDecorator(),
          // CoulombCenterDecorator(k: 10),
          HookeCenterDecorator(),
          ForceDecorator(),
          ForceMotionDecorator(),
          TimeCounterDecorator(),
          CoulombDecorator(),
          // GraphRouteDecorator()
      ]),
      convertor: MapConvertor(),
      options: Options()
        ..enableHit = true
        ..graphStyle = (
          GraphStyle()
            // ..tagColor = {"test1" : Colors.red.shade200, "test2" : Colors.orange.shade200 , "test3" : Colors.green.shade200}
            ..vertexTextStyleGetter = (vertex, shape) {
              return TextStyle(color: Colors.white);
            }
          )
        ..backgroundBuilder = (context) => Container( color: Colors.transparent )
    );
  }

}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Consumer(
          builder: (context, ref, child) {
            final Map<String, List<dynamic>> data = {"vertexes": [], "edges": []};
            
            final vertexes = ref.watch(getVertexes);
            final edges = ref.watch(getEdges);

            final isLoading = vertexes.isLoading || edges.isLoading;
            final error = vertexes.error ?? edges.error;

            return Stack(
              children: [
                if (isLoading)
                  SafeArea(
                    child: const Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: LinearProgressIndicator(),
                    ),
                  ),
                
                if (error == null)
                  Graph(data : data..["vertexes"]!.addAll(vertexes.value ?? [])  ..["edges"]!.addAll(edges.value ?? []))
                else
                  Center(child: SizedBox(width: 300, child: Text("an error occurred : $error", textAlign: TextAlign.center))),
              ],
            );
          },

        ) ,
      ),
    );
  }
}