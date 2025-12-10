import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'theme/app_theme.dart';
import 'home.dart';

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
        theme: AppTheme.darkTheme,
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
          color: Theme.of(context).colorScheme.tertiary,
          height: 100,
          padding: const EdgeInsets.all(8),
          child: NavBottomBar(),
        )
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

class NavBottomBar extends StatefulWidget {
  @override
  State<NavBottomBar> createState() => _NavBottomBarState();
}

class _NavBottomBarState extends State<NavBottomBar> {
  int _selectedRoute = 1;

  void _selectRoute(int index) {
    setState(() {
      _selectedRoute = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 35,
      children: [
        // SizedBox(
        //   height: 30,
        //   child: ,
        // )
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: () => {GoRouter.of(context).goNamed("calendar"), _selectRoute(0)}, icon: SvgPicture.asset(
              'assets/icons/calendar.svg',
              semanticsLabel: 'calendar widget',
              height: 20,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)
              )
            ),
            if (_selectedRoute == 0) Container(
              width: 6,
              height: 6,
              // margin: const EdgeInsets.only(top: 4),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                )
              ),
          ],
        )
        ,
        GestureDetector(
          onTap: () => {
            GoRouter.of(context).goNamed("home"),
            _selectRoute(1)
          },
          child: AnimatedContainer(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: _selectedRoute == 1 ? Border.all(color: Colors.white60, width: 0.4) : null,
              borderRadius: BorderRadius.all(Radius.circular(100)),
              color: _selectedRoute == 1 ? Theme.of(context).colorScheme.surface.withAlpha(82) : Colors.transparent,
            ),

            duration: Duration(milliseconds: 60),
            width: _selectedRoute == 1 ? 120 : 60,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 15,
              children: [
                SvgPicture.asset(
                  'assets/icons/home.svg',
                  semanticsLabel: 'home widget',
                  height: _selectedRoute == 1 ? 25 : 20,
                  colorFilter: ColorFilter.mode(_selectedRoute == 1 ? Theme.of(context).colorScheme.secondary : Colors.white, BlendMode.srcIn)
                ),
                if (_selectedRoute == 1 ) const Text('home', style: TextStyle(fontSize: 12, color: Colors.white)),
              ],
            ),
          )
        ),
        
        IconButton(onPressed: () => {GoRouter.of(context).goNamed("comunity"), _selectRoute(2)}, icon: Icon(Icons.arrow_forward_ios, size: 16,) ),
      ],
    );
  }
}
