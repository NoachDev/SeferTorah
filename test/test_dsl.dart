import 'package:sefertorah/core/isar/dictionaries.dart';
import 'package:sefertorah/core/isar/repositories.dart';
import 'package:sefertorah/core/models/dictionaries.dart';
import 'package:sefertorah/core/nlp/dsl.dart';
import 'package:sefertorah/core/nlp/rules.dart';
import 'package:test/test.dart';
import 'package:vector_math/vector_math.dart';

import 'repo.dart';

void main() {
  final repoController = CreateRepo();
  final dictRepo = RepositoryOfDictionaries();

  repoController.build().then((_) {
    // after the repo is builded, run the tests
    test("Test para verbo - כָּתַב ", () async {
      final dict = await dictRepo.getDictByUrl("Dict::כָּתַב");
      final ctx = dictRepo.getMorphContext(dict, 0);
      expect(classifier.classify(ctx), 'Verbo');
    });

    test("Test para pronome relativo - אֲשֶׁר ", () async {
      final dict = await dictRepo.getDictByUrl("Dict::אֲשֶׁר");
      final ctx = dictRepo.getMorphContext(dict, 0);
      expect(classifier.classify(ctx), 'Modificador');
    });

    test("Test para Modificador/Adverbio - מְאֹד ", () {
      final ctx = MorphContext(cat: Vector3(0, 0, 1), hasShoresh: false);
      expect(classifier.classify(ctx), 'Modificador');
    });

    test("Test para Subistantivo - מֹשֶׁה ", () async {
      final dict = await dictRepo.getDictByUrl("Dict::מֹשֶׁה");
      final ctx = dictRepo.getMorphContext(dict, 0);
      expect(classifier.classify(ctx), 'Substantivo Masculino');
    });

    test("Test para Subistantivo - סֵפֶר ", () async {
      final dict = await dictRepo.getDictByUrl("Dict::סֵפֶר");
      final ctx = dictRepo.getMorphContext(dict, 0);
      expect(classifier.classify(ctx), 'Substantivo Masculino');
    });

    test("Test para Particula - וְ ", () async {
      final dict = await dictRepo.getDictByUrl("Dict::וְ");
      final ctx = dictRepo.getMorphContext(dict, 0);
      expect(classifier.classify(ctx), 'Partícula gramatical');
    });

    test("Test para predicador - יֵשׁ ", () {
      final ctx = MorphContext(cat: Vector3(0, 1, 0), hasShoresh: false);
      expect(classifier.classify(ctx), 'Predicador');
    });

    test("Test para Forma verbal nominalizada - כּוֹתֵב ", () {
      final ctx = MorphContext(
        cat: Vector3(1, 1, 1),
        gender: Gender.masculine,
        binyan: null,
        mishkal: Mishkal()
          ..pattern = "קֹטֵל"
          ..type = MishkalType.nominal,
        state: GrammaticalState.absolute,
        hasShoresh: true,
      );

      expect(classifier.classify(ctx), 'Forma verbal nominalizada Masculino');
    });

    test("Test para Adjetivo - גָּדוֹל ", () {
      final ctx = MorphContext(
        cat: Vector3(0, 0, 1),
        gender: Gender.masculine,
        mishkal: Mishkal()
          ..pattern = "קֹטֵל"
          ..type = MishkalType.nominal,
        hasShoresh: true,
      );
      ;
      expect(classifier.classify(ctx), 'Adjetivo');
    });

    test("Test para Pronome - הוּא ", () {
      final ctx = MorphContext(
        cat: Vector3(1, 0, 0),
        gender: Gender.masculine,
        binyan: null,
        mishkal: null,
        state: null,
        hasShoresh: false,
      );

      expect(classifier.classify(ctx), 'Pronome Masculino');
    });
  });
}
