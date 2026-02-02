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
class TextViewer extends ConsumerWidget {
  final BooksController controller;

  const TextViewer({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metaData = ref.watch(booksMetaData);
    final pageData = ref.watch(booksPageData);

    if (metaData.value == null && metaData.error == null && !metaData.isLoading ){
      ref.read(booksMetaData.notifier).setMetaData(controller.bookName);
    }

    if (metaData.value != null && pageData.value!.isEmpty){
      ref.read(booksPageData.notifier).setPageData(controller.bookName, controller.page, metaData.value!.getChapter(controller.page));
    }

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
          controller.bookName,
          style: GoogleFonts.ruthie(color: Colors.black, fontSize: 32),
        ),

        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
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
      body: metaData.error != null
          ? Center(child: Text(metaData.error.toString()))
          : metaData.isLoading || metaData.value == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                    maxHeight: 25,
                  ),
                  // padding: const EdgeInsets.all(15.0),
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: InfoLabel(
                    chapterName: metaData.value!.getChapter(controller.page),
                    pageName: metaData.value!.getPageName(controller.page),
                  ),
                ),
                Expanded(
                  child: NotificationListener<ScrollEndNotification>(
                    onNotification: handleScrollEnd,
                    child: NotificationListener<ScrollUpdateNotification>(
                      onNotification: handleScrollUpdate,
                      child: TapRegionSurface(
                        child: pageData.error != null
                            ? Center(child: Text(pageData.error.toString()))
                            : pageData.isLoading ? const Center(child: CircularProgressIndicator()) :
                              ListView.builder(
                                itemCount: pageData.value?.length ?? 0,
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height *
                                          0.55 +
                                      10,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,

                                          children: [
                                            TextWidget(
                                              isSelected: isSelected,
                                              isScrolling: scrollState,
                                              fitScroll: fitScroll,
                                              hebrewTextKeys: pageData
                                                  .value![index]
                                                  .hebrewTextKeys,
                                              hebrewTextValues: pageData
                                                  .value![index]
                                                  .hebrewTextValues,
                                              translatedText: pageData
                                                  .value![index]
                                                  .translatedText,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(
                                                isSelected ? 15 : 8.0,
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(
                                                    () => isSelected =
                                                        !isSelected,
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
                                                        numberToCharcter(
                                                          index + 1,
                                                        ),
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
            ),
    );
  }
}
