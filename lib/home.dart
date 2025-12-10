import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'dart:math';

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


class VertexFontStyleDemo extends StatelessWidget {
  const VertexFontStyleDemo({super.key});

  @override
  Widget build(BuildContext context) {
    var r = Random();

    final vertexes = List.generate(6, (i) {
      return {
          'id': 'node$i',
          'tag': 'tag${r.nextInt(9)}',
          "solid" : true,
          'tags': [
            if (i % 3 == 0) "test1",
            if (i % 3 == 1) "test2",
            if (i % 3 == 2) "test3",
          ],
        };
    });

    final edges = List.generate(6, (i) {
      return {
        'srcId': 'node${i % 3}',
        'dstId': 'node$i',
        'solid': true,
        'edgeName': 'edge${r.nextInt(3)}',
        'ranking': DateTime.now().millisecond,
        
      };
    });

    
    var data = {
      'vertexes': vertexes,
      'edges': edges,
    };

    return FlutterGraphWidget(
      data: data,
      algorithm: ForceDirected(decorators: [
          HookeBorderDecorator(borderFactor: 0.8, k : 1, alwaysInScreen: true),
          HookeDecorator(),
          CoulombCenterDecorator(k: 10),
          HookeCenterDecorator(),
          ForceDecorator(),
          ForceMotionDecorator(),
          TimeCounterDecorator(),
          CoulombDecorator(),
          GraphRouteDecorator()
      ]),
      convertor: MapConvertor(),
      options: Options()
        ..enableHit = true
        ..graphStyle = (
          GraphStyle()
          ..tagColor = {"test1" : Colors.red.shade200, "test2" : Colors.orange.shade200 , "test3" : Colors.green.shade200}
          ..vertexTextStyleGetter = (vertex, shape) {
            return TextStyle(color: Colors.white);
          })
        // ..vertexShape = VertexCircleShape()// default is VertexCircleShape.
        
        ..backgroundBuilder = (context) => Container( color: Colors.transparent )
    );
  }

}

class Screen1 extends StatelessWidget {
  const Screen1();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        // child: VertexFontStyleDemo()
        child: VertexFontStyleDemo(),
      ),
    );
  }
}