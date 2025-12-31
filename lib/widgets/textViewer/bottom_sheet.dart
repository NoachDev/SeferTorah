import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget for the bottom sheet (ExtendedWidget) of the text widget
class TextBottomSheet extends StatelessWidget {
  final String hebrewText;
  final String translatedText;
  final String dicioKey;

  const TextBottomSheet({
    super.key,
    required this.hebrewText,
    required this.translatedText,
    required this.dicioKey,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              _Transliterated(),
              _Resources(dicioKey : dicioKey),
              _CopyWidget(
                hebrewText: hebrewText,
                translatedText: translatedText,
              ),
              _ShareWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShareWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(bottom: 10),
      child: Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share, size: 20)),
          Text("Share the passuk"),
        ],
      ),
    );
  }
}

class _CopyWidget extends StatelessWidget {
  final String hebrewText;
  final String translatedText;

  const _CopyWidget({required this.hebrewText, required this.translatedText});

  @override
  Widget build(BuildContext context) {
    List<bool> selectedLanguages = [true, false];

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            children: [
              IconButton(
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(
                      text:
                          (selectedLanguages[0] ? hebrewText : "") +
                          (selectedLanguages[1] ? translatedText : ""),
                    ),
                  );
                },
                icon: Icon(Icons.content_copy, size: 20),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff4C4C57),
                ),
                // width: 70,
                // height: 45,
                child: ToggleButtons(
                  isSelected: selectedLanguages,
                  constraints: BoxConstraints(minWidth: 60, minHeight: 45),

                  direction: Axis.horizontal,
                  borderRadius: BorderRadius.circular(10),

                  selectedColor: Theme.of(context).colorScheme.onSecondary,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  renderBorder: false,

                  onPressed: (int index) => {
                    setState(
                      () =>
                          selectedLanguages[index] = !selectedLanguages[index],
                    ),
                  },

                  children: const [
                    Text("hebrew", style: TextStyle(fontSize: 11)),
                    Text("outro", style: TextStyle(fontSize: 11)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Resources extends StatelessWidget {
  final String dicioKey;

  const _Resources({required this.dicioKey});

  @override
  Widget build(BuildContext context) {
    return Center(
      // padding: EdgeInsetsGeometry.only(left: 35, top: 10),
      child: Wrap(
        direction: Axis.vertical,
        spacing: 15,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                  width: 1,
                ),
              ),
              color: Colors.transparent,
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            height: 30,

            child: Row(
              children: [
                Text("Comentarios", style: TextStyle(fontSize: 11)),
                Spacer(),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                  width: 1,
                ),
              ),
              color: Colors.transparent,
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            height: 30,

            child: Row(
              children: [
                Text("Referencias", style: TextStyle(fontSize: 11)),
                Spacer(),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                  width: 1,
                ),
              ),
              color: Colors.transparent,
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            height: 30,

            child: Row(
              children: [
                Text("Dicionario : $dicioKey", style: TextStyle(fontSize: 11)),
                Spacer(),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Transliterated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: [
          // TODO : Sound of text
          IconButton(onPressed: () {}, icon: Icon(Icons.graphic_eq, size: 25)),
          //TODO: the transliterated text
          Text(
            "Som da transliteração e seu text",
            style: TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
