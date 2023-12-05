import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.light, seedColor: Colors.white),
          useMaterial3: true),
        home: HomePage(),
      )
    );
  }
}

class AppState extends ChangeNotifier {}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 36, 36, 38),
          height: 60,
          padding: EdgeInsets.all(8),
          child: NavBottomBar()
        )
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar({
    super.key,
    this.aname = "",
  });

  final String aname;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Color.fromARGB(0, 0, 0, 0),
      child: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          'assets/icons/$aname.svg',
          semanticsLabel: 'book widget',
          height: 15,
          color: Colors.white,
        ),
      )
    );
  }
}

class NavBottomBar extends StatelessWidget {
  const NavBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      IconBottomBar(aname: "book"),
      IconBottomBar(aname: "home"),
      CircleAvatar(
        radius: 30,
        backgroundColor: Color.fromARGB(255, 132, 127, 224),
        child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.white),
            iconSize: 20),
      ),
      IconBottomBar(aname: "calendar"),
      IconBottomBar(aname: "comunity"),
    ]);
  }
}
