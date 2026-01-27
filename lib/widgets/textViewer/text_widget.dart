import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sefertorah/providers/global.dart';
import 'package:sefertorah/widgets/textViewer/bottom_sheet.dart';

class TextWidget extends StatelessWidget {
  final List<String> hebrewTextKeys;
  final List<String> hebrewTextValues;
  final String translatedText;
  final bool isSelected;
  final Function isScrolling;
  final Function fitScroll;

  const TextWidget({
    super.key,
    required this.isSelected,
    required this.isScrolling,
    required this.fitScroll,
    // this.hebrewTextKeys = const [
    //   "וְהָאָ֗רֶץ",
    //   "הָיְתָ֥ה",
    //   "תֹ֙הוּ֙",
    //   "וָבֹ֔הוּ",
    //   "וְחֹ֖שֶׁךְ",
    //   "עַל־פְּנֵ֣י",
    //   "תְה֑וֹם",
    //   "וְר֣וּחַ",
    //   "אֱלֹהִ֔ים",
    //   "מְרַחֶ֖פֶת",
    //   "עַל־פְּנֵ֥י",
    //   "הַמָּֽיִם",
    // ],
    // this.hebrewTextValues = const [
    //   "terra",
    //   "era",
    //   "vazio",
    //   "desordenado",
    //   "escuridão",
    //   "sobre a face",
    //   "tehom",
    //   "ruach",
    //   "elohim",
    //   "pairando",
    //   "sobre a face",
    //   "água",
    // ],
    required this.hebrewTextKeys,
    required this.hebrewTextValues,
    required this.translatedText,
  }) : assert(
         hebrewTextKeys.length == hebrewTextValues.length,
         "The lenght of HebrewKeys and HebrewValues must be the same",
       ),
       assert(hebrewTextKeys.length != 0);

  @override
  Widget build(BuildContext context) {
    String? selectedWord;

    // TODO : Animate
    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(left: isSelected ? 10 : 50),
        child: Consumer(
          builder: (context, ref, child) {
            return AnimatedContainer(
              duration: Durations.long1,
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary.withAlpha(200)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                image: isSelected
                    ? DecorationImage(
                        image: AssetImage("assets/images/staticNoise.png"),
                        opacity: 0.20,
                        fit: BoxFit.fill,
                      )
                    : null,
              ),

              padding: isSelected
                  ? EdgeInsets.only(right: 20, left: 10, top: 10, bottom: 20)
                  : EdgeInsets.zero,
              child: Column(
                spacing: 10,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      direction: Axis.horizontal,
                      textDirection: TextDirection.rtl,
                      spacing: isSelected ? 10 : 5,
                      children: [
                        for (var e in hebrewTextKeys)
                          StatefulBuilder(
                            builder: (context, setState) {
                              return TapRegion(
                                onTapUpInside: (details) {
                                  if (!isScrolling()) {
                                    if (isSelected) {
                                      setState(() {
                                        selectedWord = e;
                                      });

                                      fitScroll();

                                      ref
                                          .read(extendedController.notifier)
                                          .show(
                                            TextBottomSheet(
                                              hebrewText: hebrewTextKeys.reduce(
                                                (value, element) =>
                                                    "$value $element",
                                              ),
                                              translatedText: translatedText,
                                              dicioKey: selectedWord!,
                                            ),
                                          );
                                    }
                                  }
                                },
                                onTapUpOutside: (event) {
                                  if (!isScrolling()) {
                                    setState(() {
                                      selectedWord = null;
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: isSelected && selectedWord != e
                                        ? 13
                                        : 3,
                                  ),
                                  child: Wrap(
                                    direction: Axis.vertical,
                                    verticalDirection: VerticalDirection.down,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      if (isSelected)
                                        Container(
                                          decoration: BoxDecoration(
                                            color: selectedWord == e
                                                ? Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary
                                                      .withAlpha(200)
                                                : Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          padding: selectedWord == e
                                              ? EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  top: 5,
                                                  bottom: 5,
                                                )
                                              : EdgeInsets.zero,
                                          child: Text(
                                            hebrewTextValues.elementAt(
                                              hebrewTextKeys.indexOf(e),
                                            ),
                                            softWrap: true,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: selectedWord == e
                                                  ? Theme.of(
                                                      context,
                                                    ).colorScheme.inversePrimary
                                                  : Theme.of(
                                                      context,
                                                    ).colorScheme.onPrimary,
                                            ),
                                          ),
                                        ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          e,
                                          softWrap: true,
                                          style: GoogleFonts.notoSerifHebrew(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),

                  if (!isSelected)
                    Text(
                      translatedText,
                      softWrap: true,
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.end,
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
