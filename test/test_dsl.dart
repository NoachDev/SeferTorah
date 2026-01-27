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
      final dict = await dictRepo.getDictByUrl(r"$Dict::1");

      print(dict.signatures.map((e) => e.surface));

      for (var surf in dict.signatures) {
        final sig = await dictRepo.getSignById(surf.indexSignature);
        final classify = MorphProjection().classify(sig, dict.shoresh);
        expect(classify.category, MorphologicalCategories.verb);
        expect(classify.decorations.isEmpty, true);
      }

    });

    // test("Test para Modificador/Adverbio - מְאֹד ", () {
    //   final ctx = MorphContext(cat: Vector3(0, 0, 1), hasShoresh: false, state: GrammaticalState.absolute);
    //   final classify = classifierProjection.classify(ctx);

    //   print("\t${classify.namedCategory("")}");
    //   expect(classify.category,  MorphologicalCategories.adverb);
    //   expect(classify.decorations, null);
    // });

    test("Test para Subistantivo - מֹשֶׁה ", () async {
      final dict = await dictRepo.getDictByUrl(r"$Dict::2");
      print(dict.signatures.map((e) => e.surface));

      for (var surfc in dict.signatures) {
        final sig = await dictRepo.getSignById(surfc.indexSignature);

        final classify = MorphProjection().classify(sig, dict.shoresh);
        print("\t${classify.namedCategory()}");
        expect(classify.category, MorphologicalCategories.noun);
        expect(classify.decorations.length, 1);
        expect(classify.decorations.first, Gender.masculine);
      }
    });
    
    test("Test para Subistantivo - ישראל ", () async {
      final dict = await dictRepo.getDictByUrl(r"$Dict::8");
      print(dict.signatures.map((e) => e.surface));

      for (var surfc in dict.signatures) {
        final sig = await dictRepo.getSignById(surfc.indexSignature);

        final classify = MorphProjection().classify(sig, dict.shoresh);
        print("\t${classify.namedCategory()}");
        expect(classify.category, MorphologicalCategories.noun);
        expect(classify.decorations.length, 1);
        expect(classify.decorations.first, Gender.neutral);
      }
    });
    
    test("Test para Particula - וְ ", () async {
      final dict = await dictRepo.getDictByUrl(r"$Dict::10");

      print(dict.signatures.map((e) => e.surface));

      for (var surf in dict.signatures) {
        final sig = await dictRepo.getSignById(surf.indexSignature);
        final classify = MorphProjection().classify(sig, dict.shoresh);
        expect(classify.category, MorphologicalCategories.particle);
        expect(classify.decorations.isEmpty, true);
      }
    });

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
      final dict = await dictRepo.getDictByUrl(r"$Dict::16");

      for (var surfc in dict.signatures) {
        final sig = await dictRepo.getSignById(surfc.indexSignature);
        
        final classify = MorphProjection().classify(sig, dict.shoresh);
        print("\t${classify.namedCategory()}");
        expect(classify.category, MorphologicalCategories.adjective);
      }
    });

    test("Test para Pronome - הוּא ", () async {
      final dict = await dictRepo.getDictByUrl(r"$Dict::17");

      for (var surfc in dict.signatures) {
        final sig = await dictRepo.getSignById(surfc.indexSignature);

        final classify = MorphProjection().classify(sig, dict.shoresh);
        print("\t${classify.namedCategory()}");
        expect(classify.category, MorphologicalCategories.pronoun);
        expect(classify.decorations.first, Gender.masculine);
      }
    });

    test("Test for multiply signaturies - את ", () async {
      final dict = await dictRepo.getDictByUrl(r"$Dict::14");
      final expectedMorph = {
        0: [MorphologicalCategories.particle, null],
        1: [MorphologicalCategories.pronoun, Gender.feminine],
      };
      for (final (index, surfc) in dict.signatures.indexed) {
        final sig = await dictRepo.getSignById(surfc.indexSignature);

        final classify = MorphProjection().classify(sig, dict.shoresh);
        print("\t${classify.namedCategory()}");
        final expected = expectedMorph[index];

        expect(classify.category, expected![0]);
        expect(classify.decorations.firstOrNull, expected[1]);
      }
    });

    // test("Test for multiply signaturies - אחד ", () async {
    //   final dict = await dictRepo.getDictByUrl("Dict::אחד");
    //   final expectedMorph = {
    //     0: [MorphologicalCategories.numeral, NumeralType.cardinal],
    //     2: [MorphologicalCategories.noun, Gender.masculine],
    //   };

    //   for (final (elm) in expectedMorph.entries){
    //     final sig = await dictRepo.getSignById(dict.signatures[elm.key].indexSignature);

    //     final classify = MorphProjection().classify(sig, dict.shoresh);
        
    //     print("\t${classify.namedCategory()}");
        
    //     expect(classify.category, elm.value[0]);
    //     expect(classify.decorations?.first, elm.value[1]);

    //   }
    // });

    // test("Test for Ordinal - ראשון ", () async {
    //   final dict = await dictRepo.getDictByUrl("Dict::ראשון");
    //   for (final surfc in dict.signatures) {
    //     final sig = await dictRepo.getSignById(surfc.indexSignature);

    //     final classify = MorphProjection().classify(sig, dict.shoresh);

    //     print("\t${classify.namedCategory()}");

    //     expect(classify.category, MorphologicalCategories.numeral);
    //     expect(classify.decorations?.length, 1);
    //     expect(classify.decorations?.first, NumeralType.ordinal);
    //   }
    // });
    
  });
}
