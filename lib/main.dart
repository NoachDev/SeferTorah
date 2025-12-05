import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( // app state management
      create: (context) => AppState(),
      child: MaterialApp.router(  // material app with router
        debugShowCheckedModeBanner: false,
        title: 'SeferTorah',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.light, seedColor: const Color.fromARGB(255, 0, 0, 0)),
          useMaterial3: true),
        routerConfig: _router, // router configuration
      )
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context , state, navigationShell) => RootLayout(child: navigationShell),
      branches: [
        StatefulShellBranch(routes : [
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, state) => const Screen1(),
            )
          ]
        ),
        StatefulShellBranch(routes : [
            GoRoute(
              path: '/calendar',
              name: 'calendar',
              builder: (context, state) => const Screen2(),
            )
          ]
        ),
        StatefulShellBranch(routes : [
            GoRoute(
              path: '/comunity',
              name: 'comunity',
              builder: (context, state) => const Screen3(),
            )
          ]
        ),
      ]
    ),
  ],
);

class AppState extends ChangeNotifier {
  String _currentRoute = '/home';

  String get currentRoute => _currentRoute;

  void setRoute(String route) {
    _currentRoute = route;
    notifyListeners();
  }
}

class RootLayout extends StatelessWidget {
  final Widget child;
  final StatefulNavigationShell? navigationShell ;
  const RootLayout({super.key, required this.child, this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : child,
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 36, 36, 38),
          height: 70,
          padding: const EdgeInsets.all(8),
          child: const NavBottomBar(),
        )
      ),
    );
  }
}

class Screen1 extends StatelessWidget {
  const Screen1();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela 1'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text('Tela 1', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  const Screen2();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela 2'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            const Text('Tela 2', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  const Screen3();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela 3'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.settings, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text('Tela 3', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}

// ===== BARRA DE NAVEGAÇÃO =====

class IconBottomBar extends StatelessWidget {
  final String routeName;
  final IconData icon;
  final String currentRoute;

  const IconBottomBar({
    super.key,
    required this.routeName,
    required this.icon,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = currentRoute == '/$routeName';

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).goNamed(routeName);
        context.read<AppState>().setRoute('/$routeName');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.green : Colors.white,
            size: 28,
          ),
          if (isSelected)
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(top: 4),
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            )
        ],
      ),
    );
  }
}

class NavBottomBar extends StatelessWidget {
  const NavBottomBar({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(onPressed: () => GoRouter.of(context).goNamed("calendar"), icon: SvgPicture.asset(
          'assets/icons/calendar.svg',
          semanticsLabel: 'calendar widget',
          height: 20,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)
          )
        ),
        IconButton(onPressed: () => GoRouter.of(context).goNamed("home"), icon: SvgPicture.asset(
          'assets/icons/home.svg',
          semanticsLabel: 'home widget',
          height: 20,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)
          )
        ),
        IconButton(onPressed: () => GoRouter.of(context).goNamed("comunity"), icon: SvgPicture.asset(
          'assets/icons/comunity.svg',
          semanticsLabel: 'comunity widget',
          height: 20,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)
          )
        ),
      ],
    );
  }
}
