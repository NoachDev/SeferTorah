import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sefertorah/screens/notmakedyet.dart';
import 'package:sefertorah/screens/text_viewer.dart';
import 'package:sefertorah/widgets/global.dart';
import 'theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/home.dart';
import 'util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  } catch (e) {
    // on unsupported device
  }

  runApp(const ProviderScope(child: MyApp()));
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
  initialLocation: AppRoutes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          RootLayout(child: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.calendar,
              builder: (context, state) => const NotMakedYet(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.comunity,
              builder: (context, state) => const NotMakedYet(),
            ),
          ],
        ),
      ],
    ),
    StatefulShellRoute.indexedStack(

      builder: (context, state, navigationShell) => ReadViewerLayout(body: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.textViewer,
              builder: (context, state){
                return TextViewer(controller: BooksController.initial());
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

class RootLayout extends StatelessWidget {
  final Widget child;
  const RootLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: child,
          bottomNavigationBar: SafeArea(
            child: Container(
              color: Theme.of(context).colorScheme.tertiary,
              height: 100,
              padding: const EdgeInsets.all(8),
              child: NavBottomBar(),
            ),
          ),
        ),
        ExtendedWidget(),
      ],
    );
  }
}

class ReadViewerLayout extends StatelessWidget {
  final Widget? body;

  const ReadViewerLayout({super.key, this.body});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        body!,
        ExtendedWidget()
      ],
    );
  }
}