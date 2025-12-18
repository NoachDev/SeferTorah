import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:sefertorah/screens/notmakedyet.dart';
import 'theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  runApp(const ProviderScope(
      child: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SeferTorah',
      theme: AppTheme.darkTheme,
      routerConfig: _router, // screens under Rootlayout 
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
              builder: (context, state) => HomeScreen(),
            )
          ]
        ),
        StatefulShellBranch(routes : [
            GoRoute(
              path: '/calendar',
              name: 'calendar',
              builder: (context, state) => const NotMakedYet(),
            )
          ]
        ),
        StatefulShellBranch(routes : [
            GoRoute(
              path: '/comunity',
              name: 'comunity',
              builder: (context, state) => const NotMakedYet(),
            )
          ]
        ),
      ]
    ),
  ],
);

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

class NavBottomBar extends StatefulWidget {
  const NavBottomBar({super.key});

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
        // calendar button
        if(_selectedRoute !=2 )Column(
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
        ),

        // home button
        if(_selectedRoute != 2) GestureDetector(
          onTap: () => {
            GoRouter.of(context).goNamed("home"),
            _selectRoute(1)
          },
          child: AnimatedContainer(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: _selectedRoute == 1 ? Border.all(color: Colors.white60, width: 0.8) : null,
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
                  height: _selectedRoute == 1 ? 23 : 20,
                  colorFilter: ColorFilter.mode(_selectedRoute == 1 ? Theme.of(context).colorScheme.secondary : Colors.white, BlendMode.srcIn)
                ),
                if (_selectedRoute == 1 ) const Text('home', style: TextStyle(fontSize: 12, color: Colors.white)),
              ],
            ),
          )
        ),
        
        // comnunity button
        IconButton(onPressed: () => {GoRouter.of(context).goNamed(_selectedRoute == 2 ? "home" : "comunity"), _selectRoute(_selectedRoute == 2 ? 1 : 2)}, icon: Icon(_selectedRoute == 2 ? Icons.arrow_back_ios : Icons.arrow_forward_ios, size: 18,) ),
        
        // when in comunity :
          // ziman screen 
        if (_selectedRoute == 2) IconButton(onPressed: () => {GoRouter.of(context).goNamed("comunity"), _selectRoute(2)}, icon: Icon(Icons.hourglass_empty_rounded, size: 22) ),
          // maps screen
        if (_selectedRoute == 2) IconButton(onPressed: () => {GoRouter.of(context).goNamed("comunity"), _selectRoute(2)}, icon: Icon(Icons.map_outlined, size: 22) ),
          // aleph screen
        // if (_selectedRoute == 2) IconButton(onPressed: () => {GoRouter.of(context).goNamed("comunity"), _selectRoute(2)}, icon: Icon(Icons.aleph, size: 22) ),

      ],
    );
  }
}
