import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final List<String> hebrewTextKeys;
  final List<String> hebrewTextValues;
  final String translatedText;
  final bool isSelected;

  const TextWidget({
    super.key,
    required this.isSelected,
    this.hebrewTextKeys = const [
      "וְהָאָ֗רֶץ",
      "הָיְתָ֥ה",
      "תֹ֙הוּ֙",
      "וָבֹ֔הוּ",
      "וְחֹ֖שֶׁךְ",
      "עַל־פְּנֵ֣י",
      "תְה֑וֹם",
      "וְר֣וּחַ",
      "אֱלֹהִ֔ים",
      "מְרַחֶ֖פֶת",
      "עַל־פְּנֵ֥י",
      "הַמָּֽיִם",
    ],
    this.hebrewTextValues = const [
      "e a terra",
      "era",
      "vazio",
      "desordenado",
      "a escuridão",
      "sobre a face",
      "tehom [caos]",
      "o ruach [espirito]",
      "elohim [Deus]",
      "pairando",
      "sobre a face",
      "a água",
    ],
    this.translatedText =
        "A terra era sem forma e vazia; e havia trevas sobre a face do abismo, mas o Espírito de Deus pairava sobre a face das águas",
  }) : assert(hebrewTextKeys.length == hebrewTextValues.length, "The lenght of Hebrewkeys and Hebrewvalues must be the same");

  @override
  Widget build(BuildContext context) {
    String? selectedWord;

    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(left: isSelected ? 10 : 50),
        child: AnimatedContainer(
          duration: Durations.long1,
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary.withAlpha(200)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            image: isSelected ? DecorationImage(image: AssetImage("assets/images/staticNoise.png"), opacity: 0.20, fit: BoxFit.fill) : null
          ),

          padding: isSelected
              ? EdgeInsets.only(right: 25, left: 10, top: 20, bottom: 30)
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
                            onTapInside: (details) {
                              if (isSelected) {
                                setState(() {
                                  selectedWord = e;
                                });
                              }
                            },
                            onTapOutside: (event) => setState(() {
                              selectedWord = null;
                            }),
                            child: Padding(
                              padding: EdgeInsets.only(top : isSelected && selectedWord != e ? 13 : 3),
                              child: Wrap(
                                direction: Axis.vertical,
                                verticalDirection: VerticalDirection.down,
                                crossAxisAlignment: WrapCrossAlignment.center,
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
                                        borderRadius: BorderRadius.circular(10),
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
                                        hebrewTextValues.elementAt(hebrewTextKeys.indexOf(e)),
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
                                      style: TextStyle(
                                        fontSize: isSelected ? 12 : 14,
                                      ),
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
        ),
      ),
    );
  }
}
