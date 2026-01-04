import 'package:sefertorah/core/DSL/main.dart';
import 'package:sefertorah/core/isar/dictionaries.dart';
import 'package:test/test.dart';
import 'package:vector_math/vector_math.dart';

void main() {
  group("Testar validade da DSL:", () {
    test("Test para verbo - כָּתַב ", () {
      final ctx = MorphContext(
        cat: Vector3(0, 1, 0),
        gender: Gender.masculine,
        binyan: Binyan.qal,
        hasShoresh: true,
      );
      expect(classifier.classify(ctx), 'Verbo');
    });

    test("Test para predicador - יֵשׁ ", () {
      final ctx = MorphContext(
        cat: Vector3(0, 1, 0),
        hasShoresh: false,
      );
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

    test("Test para Modificador/Adverbio - מְאֹד ", () {
      final ctx = MorphContext(
        cat: Vector3(0, 0, 1),
        hasShoresh: false,
      );
      expect(classifier.classify(ctx), 'Modificador');
    });

    test("Test para Subistantivo - סֵפֶר ", () {
      final ctx = MorphContext(
        cat: Vector3(1, 0, 0),
        gender: Gender.masculine,
        binyan: null,
        mishkal: Mishkal()
          ..pattern = "קֶטֶל"
          ..type = MishkalType.nominal, //
        state: GrammaticalState.absolute,
        hasShoresh: true,
      );

      expect(classifier.classify(ctx), 'Substantivo Masculino');
    });

    test("Test para Particula - וְ ", () {
      final ctx = MorphContext(
        cat: Vector3(0, 0, 0),
        hasShoresh: false,
      );

      expect(classifier.classify(ctx), 'Partícula gramatical');
    });
  });
}
