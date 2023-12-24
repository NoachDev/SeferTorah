import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sefertorah/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        scrollBehavior: AppScrollBehavior(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: Colors.white,
            surface: Color.fromARGB(255, 36, 36, 38),
            background: Color.fromARGB(255, 29, 29, 34),
            primary: Color.fromARGB(255, 132,127,224),
            secondary: Color.fromARGB(255, 0,166,195),
            tertiary: Color.fromARGB(255, 63, 161, 117),
            outline: Color.fromARGB(255, 0, 133, 255 ),
          ),
          useMaterial3: true),
        home: Home(),
      )
    );
  }
}

class AppState extends ChangeNotifier {}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double navHeight = 70;
    
    return Scaffold(
      body:HomePage(),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          height: navHeight,
          padding: EdgeInsets.all(8),
          child: NavBottomBar( height : navHeight)
        )
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  final double size;

  const IconBottomBar({
    super.key,
    this.aname = "",
    required this.size
  });

  final String aname;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundColor: Color.fromARGB(0, 0, 0, 0),
      child: IconButton(
        onPressed: () {},
        highlightColor: Theme.of(context).colorScheme.background,
        hoverColor: Color.fromARGB(20, 255, 255, 255),
        icon: SvgPicture.asset(
          'assets/icons/$aname.svg',
          semanticsLabel: 'book widget',
          height: size*0.60,
          color: Colors.white,
        ),
      )
    );
  }
}

class NavBottomBar extends StatelessWidget {
  final double height;

  const NavBottomBar({
    super.key,
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    double iconSize = height*0.4 ;

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      IconBottomBar(size : iconSize, aname: "book"),
      IconBottomBar(size : iconSize, aname: "home"),
      CircleAvatar(
        radius: height/2,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.white),
            iconSize: iconSize),
      ),
      IconBottomBar(size : iconSize, aname: "calendar"),
      IconBottomBar(size : iconSize, aname: "comunity"),
    ]);
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}