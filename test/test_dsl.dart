import 'package:sefertorah/core/isar/repositories.dart';
import 'package:sefertorah/core/models/dictionaries.dart';
import 'package:sefertorah/core/nlp/dsl.dart';
import 'package:test/test.dart';

// import 'package:sefertorah/core/isar/dictionaries.dart';
// import 'package:sefertorah/core/nlp/util.dart';
// import 'package:vector_math/vector_math.dart';

import 'repo.dart';

void main() {
  final repoController = CreateRepo();
  final dictRepo = RepositoryOfDictionaries();

  repoController.build().then((_) {
    // after the repo is builded, run the tests

    test("Test para verbo - כָּתַב ", () async {
      final dict = await dictRepo.getDictByUrl("Dict::כָּתַב");

      for (var sig in dict.signatures) {
        final classify = MorphProjection().classify(sig);
        print("\t${classify.namedCategory()}");
        expect(classify.category, MorphologicalCategories.verb);
        expect(classify.decorations, null);
      }

    });

    // test("Test para pronome relativo - אֲשֶׁר ", () async {
    //   final dict = await dictRepo.getDictByUrl("Dict::אֲשֶׁר");
    //   final ctx = dictRepo.getMorphContext(dict, 0);
    //   final classify = classifierProjection.classify(ctx);

    //   print("\t${classify.namedCategory("")}");
    //   expect(classify.category,  MorphologicalCategories.article); // Contexto idêntico ao artigo (sem estado)
    //   expect(classify.decorations, null);
    // });

    // test("Test para Modificador/Adverbio - מְאֹד ", () {
    //   final ctx = MorphContext(cat: Vector3(0, 0, 1), hasShoresh: false, state: GrammaticalState.absolute);
    //   final classify = classifierProjection.classify(ctx);

    //   print("\t${classify.namedCategory("")}");
    //   expect(classify.category,  MorphologicalCategories.adverb);
    //   expect(classify.decorations, null);
    // });

    test("Test para Subistantivo - מֹשֶׁה ", () async {
      final dict = await dictRepo.getDictByUrl("Dict::מֹשֶׁה");
      for (var sig in dict.signatures) {
        final classify = MorphProjection().classify(sig);
        print("\t${classify.namedCategory()}");
        expect(classify.category, MorphologicalCategories.noun);
        expect(classify.decorations?.length, 1);
        expect(classify.decorations?.first, Gender.masculine);
      }
    });

    // test("Test para Subistantivo - סֵפֶר ", () async {
    //   final dict = await dictRepo.getDictByUrl("Dict::סֵפֶר");
    //   final ctx = dictRepo.getMorphContext(dict, 0);
    //   final classify = classifierProjection.classify(ctx);

    //   print("\t${classify.namedCategory("")}");
    //   expect(classifierProjection.classify(ctx).category,  MorphologicalCategories.noun);
    //   expect(classifierProjection.classify(ctx).decorations?.length, 1);
    //   expect(classifierProjection.classify(ctx).decorations?.first, Gender.masculine);
    // });

    // test("Test para Particula - וְ ", () async {
    //   final dict = await dictRepo.getDictByUrl("Dict::וְ");
    //   final ctx = dictRepo.getMorphContext(dict, 0);
    //   final classify = classifierProjection.classify(ctx);

    //   print("\t${classify.namedCategory("")}");
    //   expect(classify.category,  MorphologicalCategories.conjunction);
    //   expect(classify.decorations, null);
    // });

    // test("Test para predicador - יֵשׁ ", () {
    //   final ctx = MorphContext(cat: Vector3(0, 1, 0), hasShoresh: false);
    //   final classify = classifierProjection.classify(ctx);

    //   print("\t${classify.namedCategory("")}");
    //   expect(classify.category, MorphologicalCategories.particle);
    // });

    // test("Test para Forma verbal nominalizada - כּוֹתֵב ", () {
    //   final ctx = MorphContext(
    //     cat: Vector3(1, 1, 1),
    //     gender: Gender.masculine,
    //     binyan: null,
    //     mishkal: Mishkal()
    //       ..pattern = "קֹטֵל"
    //       ..type = MishkalType.nominal,
    //     state: GrammaticalState.absolute,
    //     hasShoresh: true,
    //   );

    //   final classify = classifierProjection.classify(ctx);

    //   print("\t${classify.namedCategory("")}");

    //   expect(classify.category, MorphologicalCategories.verb);
    //   // expect(classify.decorations, contains(VerbForm.participle));
    //   expect(classify.decorations, contains(Gender.masculine));
    // });

    test("Test para Adjetivo - גָּדוֹל ", () async {
      final dict = await dictRepo.getDictByUrl("Dict::גָּדוֹל");

      for (var sig in dict.signatures) {
        final classify = MorphProjection().classify(sig);
        print("\t${classify.namedCategory()}");
        expect(classify.category, MorphologicalCategories.adjective);
      }
    });

    test("Test para Pronome - הוּא ", () async {
      final dict = await dictRepo.getDictByUrl("Dict::הוּא");

      for (var sig in dict.signatures) {
        final classify = MorphProjection().classify(sig);
        print("\t${classify.namedCategory()}");
        expect(classify.category, MorphologicalCategories.pronoun);
        expect(classify.decorations?.first, Gender.masculine);
      }
    });

    test("Test for multiply signaturies - את ", () async {
      final dict = await dictRepo.getDictByUrl("Dict::את");
      final expectedMorph = {
        0: [MorphologicalCategories.particle, null],
        1: [MorphologicalCategories.pronoun, Gender.feminine],
      };
      for (final (index, sig) in dict.signatures.indexed) {
        final classify = MorphProjection().classify(sig);
        print("\t${classify.namedCategory()}");
        final expected = expectedMorph[index];

        expect(classify.category, expected![0]);
        expect(classify.decorations?.first, expected[1]);
      }
    });

    test("Test for multiply signaturies - אחד ", () async {
      final dict = await dictRepo.getDictByUrl("Dict::אחד");
      final expectedMorph = {
        0: [MorphologicalCategories.numeral, NumeralType.cardinal],
        2: [MorphologicalCategories.noun, Gender.masculine],
      };

      for (final (elm) in expectedMorph.entries){
        final classify = MorphProjection().classify(dict.signatures[elm.key]);
        
        print("\t${classify.namedCategory()}");
        
        expect(classify.category, elm.value[0]);
        expect(classify.decorations?.first, elm.value[1]);

      }
    });

    test("Test for Ordinal - ראשון ", () async {
      final dict = await dictRepo.getDictByUrl("Dict::ראשון");
      for (final sig in dict.signatures) {
        final classify = MorphProjection().classify(sig);

        print("\t${classify.namedCategory()}");

        expect(classify.category, MorphologicalCategories.numeral);
        expect(classify.decorations?.length, 1);
        expect(classify.decorations?.first, NumeralType.ordinal);
      }
    });
  });
}
