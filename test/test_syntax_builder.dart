import 'package:sefertorah/core/isar/repositories.dart';
import 'package:sefertorah/core/nlp/syntax_builder.dart';
import 'package:test/test.dart';

import 'repo.dart';

void main() {
  final repoController = CreateRepo();
  final dictRepo = RepositoryOfDictionaries();

  repoController.build().then((_) {
    // after the repo is builded, run the tests

    test("VSO - כָּתַב מֹשֶׁה סֵפֶר", () async {
      final String normSentence = "\$Dict::סֵפֶר\$Dict::מֹשֶׁה\$Dict::כָּתַב";
      final List<SyntaxToken> tokensSentence = [];

      print("\tCreating tokens...");

      for (var url in dictRepo.getUrlFromSentence(normSentence).reversed) {
        print("\t\tgeting dict from url: $url");

        final dict = await dictRepo.getDictByUrl(url);
        final projections = dict.signatures.map(
          (sign) => SyntacticProjection.create(sign),
        );

        tokensSentence.add(
          SyntaxToken(
            index: tokensSentence.length,
            surface: dict.word,
            projections: projections.toList(),
          ),
        );
      }

      print("\ttokensSentence lenght: ${tokensSentence.length}");

      final syntaxBuilder = SyntaxBuilder();

      print("\tBuilding syntax graph...");
      syntaxBuilder.build(tokensSentence);

      print("\t\tlenght syntax trees: ${syntaxBuilder.hypotheses.length}");

      for (var state in syntaxBuilder.hypotheses) {
        print("\t\tSyntax Tree Score: ${state.score}");

        for (var node in state.toListString()) {
          print("\t\t\tNode: $node");
        }
      }
    });

    test(
      "וַיִּכְתֹּב מֹשֶׁה אֶת־הַסֵּפֶר אֲשֶׁר נָתַן הַנָּשִׂיא לְבְנֵי יִשְׂרָאֵל בַּמִּדְבָּר",
      () async {
        final String normSentence =
            "\$Dict::מִּדְבָּר\$Dict::בַּ\$Dict::יִשְׂרָאֵל\$Dict::בְנֵי\$Dict::לְ\$Dict::נָּשִׂיא\$Dict::הַ\$Dict::נָתַן\$Dict::אֲשֶׁר\$Dict::סֵּפֶר\$Dict::הַ::־\$Dict::אֶת\$Dict::מֹשֶׁה\$Dict::כְתֹּב\$Dict::יִּ\$Dict::וַ";

        final List<SyntaxToken> tokensSentence = [];

        print("\tCreating tokens...");

        for (var url in dictRepo.getUrlFromSentence(normSentence).reversed) {
          print("\t\tgeting dict from url: $url");

          final dict = await dictRepo.getDictByUrl(url);
          final projections = dict.signatures.map(
            (sign) => SyntacticProjection.create(sign),
          );

          tokensSentence.add(
            SyntaxToken(
              index: tokensSentence.length,
              surface: dict.word,
              projections: projections.toList(),
            ),
          );
        }

        print("\ttokensSentence lenght: ${tokensSentence.length}");

        final syntaxBuilder = SyntaxBuilder();

        print("\tBuilding syntax graph...");
        syntaxBuilder.build(tokensSentence);

        print("\t\tlenght syntax trees: ${syntaxBuilder.hypotheses.length}");

        for (var state in syntaxBuilder.hypotheses) {
          print("\t\tSyntax Tree Score: ${state.score}");

          for (var (index, node) in state.toListString().indexed) {
            print("\t\t\t${tokensSentence[index].surface} : $node");
          }
        }
      },
    );
  });
}
