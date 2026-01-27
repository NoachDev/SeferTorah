import 'package:sefertorah/core/isar/repositories.dart';
import 'package:test/test.dart';

import 'repo.dart';

void main() {
  final repoController = CreateRepo();

  repoController.build().then((_) {
    /// after the repo is builded, run the tests

    group("VSO - כָּתַב מֹשֶׁה סֵפֶר", () {
      final String normSentence = r"$Dict::3$Dict::2$Dict::1";
      final verse = RepoOfOneVerse(normSentence);

      test("Creating tokens ...", () async {
        await verse.buildTokens();
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
        expect(lin.join().trim(), "Moises escrever livro");
      });

      /// end of group
    });

    group(
      "וַיִּכְתֹּב מֹשֶׁה אֶת־הַסֵּפֶר אֲשֶׁר נָתַן הַנָּשִׂיא לְבְנֵי יִשְׂרָאֵל בַּמִּדְבָּר",
      () {
        final String normSentence =
            r"$Group{$Dict::9$Dict::12}$Dict::8$Group{$Dict::7$Dict::13$}$Group{$Dict::6$Dict::11}$Dict::5$Dict::4$Group{$Dict::3$Dict::11$Mark::־$Dict::14}$Dict::2$Group{$Dict::1$Dict::15$Dict::10}";

        final verse = RepoOfOneVerse(normSentence);

        // print(verse.normSentence);

        test("Creating tokens ...", () async {
          await verse.buildTokens();
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

          final hyp = verse.syntaxBuilder.hypotheses.first;
          
          // final node12 = hyp.nodes[12];
          // final node13 = hyp.nodes[13];
          // print(node12.projection.category.name);
          // print(node12.projection.source.abstractLexicalTraits?.grammaticalState);
          // print(verse.tokensSentence[12].projections[0].source.categoricalTraits);

          // print(node13.projection.category.name);
          // print(verse.tokensSentence[13].projections[0].source.categoricalTraits);

          for (final (index, node)
              in hyp.toListString().indexed) {
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

          expect(lin.join().trim(), "e Moises escrever o livro que o lider dar para filhos israel no deserto");
        });

        // end of group
      },
    );
  });
}
