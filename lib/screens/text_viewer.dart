import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sefertorah/util.dart';
import 'package:sefertorah/widgets/textViewer/text_widget.dart';

interface class BooksController {
  final List<String> booksName;
  final List<Color> colors;
  final Map<int, int?>? pagesInBook;
  final Map<int, int?>? versosInPage;

  BooksController(
    this.booksName,
    this.colors,
    this.pagesInBook,
    this.versosInPage,
  );

  @Deprecated('only for tests')
  factory BooksController.initial() => BooksController(
    const ["Sefer Any"],
    [Colors.lightBlue.shade100],
    {1: 1},
    null,
  );
}

/// decimal numer to hebrew system
///
/// only for numbers less than 400
String numberToCharcter(int number) {
  String ret = "";
  String num = number.toString();
  int countNum = number;

  Map<int, String> p2p = {
    1: "א",
    2: "ב",
    3: "ג",
    4: "ד",
    5: "ה",
    6: "ו",
    7: "ז",
    8: "ח",
    9: "ט",
    10: "י",
    20: "כ",
    30: "ל",
    40: "מ",
    50: "נ",
    60: "ס",
    70: "ע",
    80: "פ",
    90: "צ",
    100: "ק",
    200: "ר",
    300: "ש",
    400: "ת",
  };

  for (var i = num.length - 1; i >= 0; i--) {
    if (i < 3) {
      int mul = pow(10, i).toInt();
      int numAbs = (countNum / mul).floor() * mul;
      countNum = countNum - numAbs;

      if (numAbs == 0) {
        continue;
      }

      ret += p2p[numAbs]!;
    }
  }

  return ret;
}

class TextViewer extends StatelessWidget {
  final BooksController controller;

  const TextViewer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    bool isScrolling = false;

    /// get the latest state of the scroll
    ///
    /// usable in children widgets
    bool scrollState() {
      return isScrolling;
    }

    /// listen the state of scroll and signal when are scrolling
    ///
    /// [notifications] is a ScrollNotification 
    bool handleScrollUpdate(ScrollUpdateNotification notification) {
      if (!isScrolling) {
        isScrolling = true;
      }

      return false;
    }

    bool handleScrollEnd(ScrollEndNotification notification) {
      isScrolling = false;
      return false;
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,

        backgroundColor: controller.colors.first,

        title: Text(
          controller.booksName.first,
          style: const TextStyle(
            fontFamily: "Ruthie",
            color: Colors.black,
            fontSize: 32,
          ),
        ),

        leading: IconButton(
          onPressed: () => GoRouter.of(context).pop(),
          icon: const Icon(Icons.chevron_left, color: Colors.black),
        ),

        actions: [
          IconButton(
            onPressed: () => GoRouter.of(context).go(AppRoutes.home),
            icon: const Icon(Icons.close, color: Colors.black, size: 20),
          ),
        ],
      ),

      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Wrap(
                spacing: 15,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text("Capitulo : Test"),
                  Container(
                    width: 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    height: 25,
                  ),
                  Text("Pagina : Test"),
                ],
              ),
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollEndNotification>(
              onNotification: handleScrollEnd,
              child: NotificationListener<ScrollUpdateNotification>(
                onNotification: handleScrollUpdate,
                child: TapRegionSurface(
                  child: ListView.builder(
                    itemCount: 10,
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.55 + 10,
                    ),

                    itemBuilder: (context, index) {
                      bool isSelected = false;
                      GlobalObjectKey key = GlobalObjectKey(index);

                      void fitScroll() => Scrollable.ensureVisible(
                        key.currentContext!,
                        alignment: 0.1,
                        duration: Durations.long3,
                      );

                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: isSelected ? 20 : 15,
                            ),
                            child: Row(
                              key: key,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                TextWidget(
                                  isSelected: isSelected,
                                  isScrolling: scrollState,
                                  fitScroll : fitScroll
                                ),
                                Padding(
                                  padding: EdgeInsets.all(
                                    isSelected ? 10 : 20.0,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() => isSelected = !isSelected);

                                      if (isSelected) {
                                        fitScroll();
                                      }
                                    },
                                    icon: isSelected
                                        ? Icon(
                                            Icons.chevron_right,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimary,
                                          )
                                        : Text(numberToCharcter(index + 1)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
