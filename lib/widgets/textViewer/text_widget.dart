import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(left: 50),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          spacing: 10,
          children: [
            const Text(
              "וְהָאָרֶץ, הָיְתָה תֹהוּ וָבֹהוּ, וְחֹשֶׁךְ, עַל-פְּנֵי תְהוֹם; וְרוּחַ אֱלֹהִים, מְרַחֶפֶת עַל-פְּנֵי הַמָּיִם",
              softWrap: true,
              textAlign: TextAlign.end,
            ),
            const Text(
              "A terra era sem forma e vazia; e havia trevas sobre a face do abismo, mas o Espírito de Deus pairava sobre a face das águas",
              softWrap: true,
              style: TextStyle(fontSize: 10),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
