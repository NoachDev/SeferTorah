import 'package:sefertorah/core/isar/lexical_sense.dart';
import 'package:sefertorah/core/isar/repositories.dart';
import 'package:sefertorah/core/nlp/semantic_builder.dart';
import 'package:sefertorah/core/nlp/syntax_builder.dart';
import 'package:test/test.dart';

import 'repo.dart';

void main() {
  final repoController = CreateRepo();
  final dictRepo = RepositoryOfDictionaries();

  repoController.build().then((_) {
    // after the repo is builded, run the tests

    group("VSO - כָּתַב מֹשֶׁה סֵפֶר", () {
      final String normSentence = "\$Dict::סֵפֶר\$Dict::מֹשֶׁה\$Dict::כָּתַב";
      final verse = RepoOfOneVerse();

      test("Creating tokens ...", () async {
        await verse.buildTokens(normSentence);
        expect(verse.tokensSentence.length, 3);
      });

      test("Create syntax graph ...", () {
        verse.buildedSynataxGraph;

        expect(verse.syntaxBuilder.hypotheses.length <= 5, true);
        expect(verse.syntaxBuilder.hypotheses.length, 4);

        for (var state in verse.syntaxBuilder.hypotheses) {
          print("\tSyntax Tree Score: ${state.score}");

          for (var node in state.toListString()) {
            print("\t\tNode: $node");
          }
        }
      });

      test("Create semantics graphs ...", () async {
        expect(await verse.buildedSemanticGraph, true);

        expect(verse.semanticGraphs.length, 4);

        for (var semantic in verse.semanticGraphs) {
          print("\t ${semantic.graph.toString()}");

          for (var edge in semantic.graph.edges) {
            print("\t\tEdge: ${edge.toString()}");
          }
        }
      });
    });

    group(
      "וַיִּכְתֹּב מֹשֶׁה אֶת־הַסֵּפֶר אֲשֶׁר נָתַן הַנָּשִׂיא לְבְנֵי יִשְׂרָאֵל בַּמִּדְבָּר",
      () {
        final String normSentence =
            "\$Dict::מִּדְבָּר\$Dict::בַּ\$Dict::יִשְׂרָאֵל\$Dict::בְנֵי\$Dict::לְ\$Dict::נָּשִׂיא\$Dict::הַ\$Dict::נָתַן\$Dict::אֲשֶׁר\$Dict::סֵּפֶר\$Dict::הַ::־\$Dict::אֶת\$Dict::מֹשֶׁה\$Dict::כְתֹּב\$Dict::יִּ\$Dict::וַ";

        final verse = RepoOfOneVerse();

        test("Creating tokens ...", () async {
          await verse.buildTokens(normSentence);
          expect(verse.tokensSentence.length, 16);
        });

        test("Create syntax graph ...", () {
          verse.buildedSynataxGraph;

          expect(verse.syntaxBuilder.hypotheses.length, 5);

          for (var state in verse.syntaxBuilder.hypotheses) {
            print("\tSyntax Tree Score: ${state.score}");

            for (var node in state.toListString()) {
              print("\t\tNode: $node");
            }
          }
        });

        test("Create semantics graphs ...", () async {
          expect(await verse.buildedSemanticGraph, true);

          expect(verse.semanticGraphs.length, 5);

          for (var semantic in verse.semanticGraphs) {
            print("\t ${semantic.graph.toString()}");

            for (var edge in semantic.graph.edges) {
              print("\t\tEdge: ${edge.toString()}");
            }
          }
        });
      },
    );
  });
}
