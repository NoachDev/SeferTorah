import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sefertorah/providers/global.dart';
import 'package:sefertorah/util.dart';

class ExtendedWidget extends ConsumerStatefulWidget {
  const ExtendedWidget({super.key});

  @override
  ConsumerState<ExtendedWidget> createState() => _ExtendedWidgetState();
}

class _ExtendedWidgetState extends ConsumerState<ExtendedWidget> {
  // the iverse of height
  late double startPosition;
  final endPosition = 0.0;
  double position = 0.0;

  // control state for when to show change position adequaly
  bool onExecution = false;

  /// Function for control the position on end
  ///
  /// if the coditions is not sufficient back the widget to top
  /// if satisfies move it to bottom
  void setEndPosition(double velocity) {
    // if the pan is fast or the position are sufficiently draged, so hidden him
    if (velocity >= -startPosition || position <= startPosition * 0.4) {
      ref.read(extendedController.notifier).hide();
      return;
    }

    setState(() {
      position = endPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    final child = ref.watch(extendedController);
    final show = ref.read(extendedController.notifier).showWidget;

    startPosition = -MediaQuery.of(context).size.height * 0.5;

    /// only climb if the aplication is not running, and
    /// only down if the aplication is not running
    if (show) {
      if (!onExecution) {
        position = endPosition;
        onExecution = true;
      }
    } else {
      onExecution = false;
      position = startPosition;
    }

    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      bottom: position,
      curve: Curves.ease,

      child: Container(
        width: MediaQuery.of(context).size.width,
        height: -startPosition,

        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),

        child: Column(
          children: [
            GestureDetector(
              onPanUpdate: (details) => {
                setState(() {
                  // all values between zero and startPosition
                  position = max(
                    startPosition,
                    min(0, position - details.delta.dy),
                  );
                }),
              },
              onPanEnd: (details) => {
                setEndPosition(details.velocity.pixelsPerSecond.dy),
              },

              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,

                child: Center(
                  child: Container(
                    width: 70,
                    height: 6,
                    margin: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
              ),
            ),

            Expanded(child: child ?? const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}

class NavBottomBar extends StatefulWidget {
  const NavBottomBar({super.key});

  @override
  State<NavBottomBar> createState() => _BottomBarState();
}

class _IconOfBottomBar extends StatelessWidget {
  final Widget icon;
  final int route;
  final int currentRoute;
  final Function(int) select;
  const _IconOfBottomBar({
    required this.icon,
    required this.route,
    required this.select,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => select(route),
          icon : icon,
        ),
        if (route == currentRoute)
          Container(
            width: 6,
            height: 6,
            // margin: const EdgeInsets.only(top: 4),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}

class _BottomBarState extends State<NavBottomBar> {
  int _selectedRoute = 1;
  void selectRoute(int value) => {
    setState(() {
      _selectedRoute = value;
    }),

    switch (value) {
      0 => GoRouter.of(context).go(AppRoutes.calendar),
      1 => GoRouter.of(context).go(AppRoutes.home),
      2 => GoRouter.of(context).go(AppRoutes.comunity),
      _ => null,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 23,
      children: [
        // calendar button
        if (_selectedRoute < 2)
          _IconOfBottomBar(
            icon: SvgPicture.asset(
              'assets/icons/calendar.svg',
              semanticsLabel: 'calendar widget',
              height: 20,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
            route: 0,
            currentRoute: _selectedRoute,
            select: selectRoute,
          ),

        // home button
        if (_selectedRoute < 2)
          GestureDetector(
            onTap: () => selectRoute(1),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: _selectedRoute == 1
                    ? Border.all(color: Colors.white60, width: 0.8)
                    : null,
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: _selectedRoute == 1
                    ? Theme.of(context).colorScheme.surface.withAlpha(82)
                    : Colors.transparent,
              ),

              duration: Duration(milliseconds: 60),
              width: _selectedRoute == 1 ? 112 : 60,
              height: 47,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 14,
                children: [
                  SvgPicture.asset(
                    'assets/icons/home.svg',
                    semanticsLabel: 'home widget',
                    width: 23,
                    colorFilter: ColorFilter.mode(
                      _selectedRoute == 1
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  if (_selectedRoute == 1)
                    const Text(
                      'home',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                ],
              ),
            ),
          ),

        // comnunity button
        IconButton(
          onPressed: () => {selectRoute(_selectedRoute >= 2 ? 1 : 2)},
          icon: Icon(
            _selectedRoute >= 2
                ? Icons.arrow_back_ios
                : Icons.arrow_forward_ios,
            size: 18,
          ),
        ),

        // when in comunity :

        // ziman screen
        if (_selectedRoute >= 2)
          _IconOfBottomBar(
            icon: Icon(Icons.hourglass_empty_rounded, size: 22),
            route: 3,
            currentRoute: _selectedRoute,
            select: selectRoute,
          ),
        // maps screen
        if (_selectedRoute >= 2)
          _IconOfBottomBar(
            icon: Icon(Icons.map_outlined, size: 22),
            route: 4,
            currentRoute: _selectedRoute,
            select: selectRoute,
          ),

        // aleph screen
        // if (_selectedRoute == 2) IconButton(onPressed: () => {GoRouter.of(context).goNamed("comunity"), _selectRoute(2)}, icon: Icon(Icons.aleph, size: 22) ),
      ],
    );
  }
}
