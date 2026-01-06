import 'package:sefertorah/core/isar/repositories.dart';
import 'package:sefertorah/core/nlp/syntax_builder.dart';
import 'package:test/test.dart';

import 'repo.dart';

void main() {
  final repoController = CreateRepo();
  final dictRepo = RepositoryOfDictionaries();

  // old
  // group("test for simple clause", () {
  //   test("VSO - כָּתַב מֹשֶׁה סֵפֶר", () async {
  //     await repoController.isInitilezed;

  //     final String normSentence = "\$Dict::כָּתַב\$Dict::מֹשֶׁה\$Dict::סֵפֶר";
  //     final List<List<MorphReading>> tokenSentence = [];

  //     for (var url in dictRepo.getUrlFromSentence(normSentence)) {
  //       print("\tgeting dict from url: $url");

  //       final dict = await dictRepo.getDictByUrl(url);
  //       tokenSentence.add([await dictRepo.getMorphReading(dict, 0, 1.0)]);
  //     }

  //     print("\ttokenSentence lenght: ${tokenSentence.length}");

  //     final syntaxBuilder = SyntaxBuilder();
  //     final syntaxTrees = syntaxBuilder.build(tokenSentence);

  //     print("\tlenght syntax trees: ${syntaxTrees.length}");

  //     expect(syntaxTrees.length, 1);

  //     for (var tree in syntaxTrees) {
  //       print("\tSyntax Tree Score: ${tree.score}");

  //       final SemanticEvent event = syntaxBuilder.fromSyntax(tree);

  //       expect(
  //         event.toString(),
  //         "SemanticEvent(predicate: escrever, agent: Moshe, theme: livro)",
  //       );
  //     }

  //     // expect(, )
  //   });
  // });
  // repoController.isInitilezed.then((_) {

  // });

  repoController.build().then((_) {
    // after the repo is builded, run the tests

    test("VSO - כָּתַב מֹשֶׁה סֵפֶר", () async {
      final String normSentence = "\$Dict::סֵפֶר\$Dict::מֹשֶׁה\$Dict::כָּתַב";
      final List<SyntaxToken> tokensSentence = [];

      print("\tCreating tokens...");

      for (var url in dictRepo.getUrlFromSentence(normSentence).reversed) {
        print("\t\tgeting dict from url: $url");

        final dict = await dictRepo.getDictByUrl(url);
        var morphs = List.generate(dict.assinatures.length, (index) {
          return dictRepo.getMorphReading(dict, index, 1.0);
        });

        var projections = morphs
            .map((elm) async => SyntacticProjection.fromMorphReading(await elm))
            .toList();

        for (var proj in projections) {
          print("\t\t\tProjection from morph : ${await proj.then((value) => value.toString())}");
        }

        tokensSentence.add(
          SyntaxToken(
            index: tokensSentence.length,
            // surface: dict.word, --- IGNORE ---
            projections: await Future.wait(projections),
          ),
        );
      }

      print("\ttokensSentence lenght: ${tokensSentence.length}");

      final syntaxBuilder = SyntaxBuilder();

      print("\tBuilding syntax graph...");
      final synatxResult = syntaxBuilder.build(tokensSentence);

      print("\t\tlenght syntax trees: ${synatxResult.length}");

      for (var state in synatxResult) {
        print("\t\tSyntax Tree Score: ${state.score}");
        
        for (var node in state.toListString()) {
          print("\t\t\tNode: $node");
        }
      }
    });

    // test(
    //   "וַיִּכְתֹּב מֹשֶׁה אֶת־הַסֵּפֶר אֲשֶׁר נָתַן הַנָּשִׂיא לְבְנֵי יִשְׂרָאֵל בַּמִּדְבָּר",
    //   () async {
    //     final String normSentence =
    //         "\$Dict::מִּדְבָּר\$Dict::בַּ\$Dict::יִשְׂרָאֵל\$Dict::בְנֵי\$Dict::לְ\$Dict::נָּשִׂיא\$Dict::הַ\$Dict::נָתַן\$Dict::אֲשֶׁר\$Dict::סֵּפֶר\$Dict::הַ::־\$Dict::אֶת\$Dict::מֹשֶׁה\$Dict::כְתֹּב\$Dict::יִּ\$Dict::וַ";

    //     final List<SyntaxToken> tokensSentence = [];

    //     print("\tCreating tokens...");

    //     for (var url in dictRepo.getUrlFromSentence(normSentence).reversed) {
    //       print("\t\tgeting dict from url: $url");

    //       final dict = await dictRepo.getDictByUrl(url);
    //       var morphs = List.generate(dict.assinatures.length, (index) {
    //         return dictRepo.getMorphReading(dict, index, 1.0);
    //       });

    //       var projections = morphs
    //           .map(
    //             (elm) async => SyntacticProjection.fromMorphReading(await elm),
    //           )
    //           .toList();

    //       tokensSentence.add(
    //         SyntaxToken(
    //           index: tokensSentence.length,
    //           // surface: dict.word, --- IGNORE ---
    //           projections: await Future.wait(projections),
    //         ),
    //       );
    //     }

    //     print("\ttokensSentence lenght: ${tokensSentence.length}");

    //     final syntaxBuilder = SyntaxBuilder();
    //     final synatxResolut = syntaxBuilder.build(tokensSentence);

    //     print(synatxResolut.length);

    //     for (var state in synatxResolut) {
    //       print("\tSyntax Tree Score: ${state.score}");

    //       print(state.toString());
    //     }
    //   },
    // );
  });
}
