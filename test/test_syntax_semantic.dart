import 'package:sefertorah/core/isar/repositories.dart';
import 'package:test/test.dart';

import 'repo.dart';

void main() {
  final repoController = CreateRepo();
  final dictRepo = RepositoryOfDictionaries();

  repoController.build().then((_) {
    /// after the repo is builded, run the tests

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

      test("Translate", () {
        var semantic = verse.semanticGraphs.first;
        var lin = semantic.linearizationSVO();
        expect(lin.join().trim(), "Moshe escrever livro");
      });

      /// end of group
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

          /// verify if th syntax builder choose "et" was particle by heuristic
          expect(
            verse.syntaxBuilder.hypotheses.any(
              (elm) => elm.nodes.any(
                (node) =>
                    node.tokenIndex == 4 &&
                    node.projection == verse.tokensSentence[4].projections[0],
              ),
            ),
            true,
          );

          Map expec = {
            0: "Node(0)->[modifier->Node(1)]",
            1: "Node(1)->[connector->Node(2)]",
            3: "Node(3)->[subject->Node(2)]",
            4: "Node(4)->[connector->Node(5)]",
            5: "Node(5)->[modifier->Node(6)]",
            6: "Node(6)->[object->Node(2)]",
            7: "Node(7)->[modifier->Node(8)]",
            9: "Node(9)->[modifier->Node(10)]",
            10: "Node(10)->[subject->Node(8)]",
            11: "Node(11)->[modifier->Node(12)]",
            12: "Node(12)->[object->Node(8)]",
            13: "Node(13)->[complement->Node(12)]",
            14: "Node(14)->[modifier->Node(15)]",
            15: "Node(15)->[complement->Node(12)]",
          };

          for (final (index, node)
              in verse.syntaxBuilder.hypotheses.first.toListString().indexed) {
            // print("\t\tNode: $node");

            if (expec.containsKey(index)) {
              expect(node, expec[index]);
            }
          }
        });

        test("Create semantics graphs ...", () async {
          expect(await verse.buildedSemanticGraph, true);

          expect(verse.semanticGraphs.length, 5);
        });

        test("Translate", () {
          var semantic = verse.semanticGraphs.first;
          var lin = semantic.linearizationSVO();

          expect(lin.join().trim(), "e Moshe escrever o livro que o lider dar para filhos israel no deserto");
        });

        // end of group
      },
    );
  });
}
