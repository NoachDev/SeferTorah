import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sefertorah/core/models/text_viewer.dart';
import 'package:sefertorah/providers/text_viewer.dart';
import 'package:sefertorah/util.dart';
import 'package:sefertorah/widgets/textViewer/info_label.dart';
import 'package:sefertorah/widgets/textViewer/text_widget.dart';

/// decimal numer to hebrew system
///
/// only for numbers less than 400
@Deprecated("old function")
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

/// TODO : make the features of controller
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
          style: GoogleFonts.ruthie(color: Colors.black, fontSize: 32),
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

      /// TODO : Save and Load preview scroll ( verse ) and page - when null
      body: Consumer(
        builder: (context, ref, child) {
          var metaData = ref.watch(booksMetaData(controller.booksName.first));

          if (metaData.error != null) {
            return Center(child: Text(metaData.error.toString()));
          }
          
          if (metaData.isLoading){
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: 25,
                ),
                // padding: const EdgeInsets.all(15.0),
                margin: EdgeInsets.symmetric(vertical: 15),
                child: InfoLabel(chpterName: metaData.value![0][0].name!, pageName: metaData.value![1][0],),
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
                          bottom:
                              MediaQuery.of(context).size.height * 0.55 + 10,
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
                                      fitScroll: fitScroll,
                                      hebrewTextKeys: ["", ""],
                                      hebrewTextValues: ["terra", "era"],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(
                                        isSelected ? 15 : 8.0,
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          setState(
                                            () => isSelected = !isSelected,
                                          );

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
                                            : Text(
                                                numberToCharcter(index + 1),
                                                style:
                                                    GoogleFonts.notoSansHebrew(
                                                      fontSize: 16,
                                                    ),
                                              ),
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
          );
        },
      ),
    );
  }
}

