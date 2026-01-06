import 'package:isar/isar.dart';
import 'package:sefertorah/core/isar/isar_setup.dart';
import 'package:sefertorah/core/isar/dictionaries.dart';
import 'package:sefertorah/core/isar/lexical_sense.dart';
import 'package:sefertorah/core/models/dictionaries.dart';

class CreateRepo {
  int? senseLenght;
  int? dictLenght;

  Future<bool> _createDict() async {
    await isar.writeTxn(() async {
      List<Dict> words = [
        Dict(
          word: "כתב",
          origin: Origin.native,
          stage: Stage.biblical,
          assinatures: [
            Assinatures()
              ..categoricalTraits = [0, 1, 0]
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..binyan = Binyan.qal
                ..gender = Gender.masculine)
              ..abstractLexicalTraits = (LexicalTraits()
                ..shoresh = (Shoresh()
                  ..root = "כתב"
                  ..weak = false)
                ..grammaticalState = null),
          ],
        ),
        Dict(
          word: "משה",
          origin: Origin.native,
          stage: Stage.biblical,
          assinatures: [
            Assinatures()
              ..categoricalTraits = [1, 0, 0]
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..mishqal = (Mishkal()
                  ..pattern = "קֶטֶל"
                  ..type = MishkalType.nominal)
                ..gender = Gender.masculine)
              ..abstractLexicalTraits = (LexicalTraits()
                ..grammaticalState = null),
          ],
        ),
        Dict(
          word: "ספר",
          origin: Origin.native,
          stage: Stage.biblical,
          assinatures: [
            Assinatures()
              ..categoricalTraits = [1, 0, 0]
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..mishqal = (Mishkal()
                  ..pattern = "קֶטֶל"
                  ..type = MishkalType.nominal)
                ..gender = Gender.masculine)
              ..abstractLexicalTraits = (LexicalTraits()
                ..grammaticalState = null),
          ],
        ),
        Dict(
          word: "אשר",
          origin: Origin.native,
          stage: Stage.biblical,
          assinatures: [
            Assinatures()
              ..categoricalTraits =
                  [0, 0, 1] // mod / connector
              ..internalMorphologicalTraits = null
              ..abstractLexicalTraits = (LexicalTraits()
                ..shoresh = null
                ..grammaticalState = null),
          ],
        ),
        Dict(
          word: "נתן",
          origin: Origin.native,
          stage: Stage.biblical,
          assinatures: [
            Assinatures()
              ..categoricalTraits =
                  [0, 1, 0] // pred
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..binyan = Binyan.qal
                ..tense = VerbForm.participle
                ..gender = Gender.masculine)
              ..abstractLexicalTraits = (LexicalTraits()
                ..shoresh = (Shoresh()
                  ..root = "נתן"
                  ..weak = true)
                ..grammaticalState = null),
          ],
        ),
        Dict(
          word: "נשיא",
          origin: Origin.native,
          stage: Stage.biblical,
          assinatures: [
            Assinatures()
              ..categoricalTraits =
                  [1, 0, 0] // ref
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..gender = Gender.masculine
                ..number = Number.singular)
              ..abstractLexicalTraits = (LexicalTraits()
                ..shoresh = null
                ..grammaticalState = GrammaticalState.absolute),
          ],
        ),

        Dict(
          word: "בני",
          origin: Origin.native,
          stage: Stage.biblical,
          assinatures: [
            Assinatures()
              ..categoricalTraits =
                  [1, 0, 0] // ref
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..gender = Gender.masculine
                ..number = Number.plural)
              ..abstractLexicalTraits = (LexicalTraits()
                ..shoresh = (Shoresh()
                  ..root = "בן"
                  ..weak = false)
                ..grammaticalState = GrammaticalState.construct),
          ],
        ),
        Dict(
          word: "ישראל",
          origin: Origin.native,
          stage: Stage.biblical,
          assinatures: [
            Assinatures()
              ..categoricalTraits =
                  [1, 0, 0] // ref
              ..internalMorphologicalTraits = null
              ..abstractLexicalTraits = (LexicalTraits()
                ..shoresh = null
                ..grammaticalState = GrammaticalState.absolute),
          ],
        ),
        Dict(
          word: "מדבר",
          origin: Origin.native,
          stage: Stage.biblical,
          assinatures: [
            Assinatures()
              ..categoricalTraits =
                  [1, 0, 0] // ref
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..gender = Gender.masculine
                ..number = Number.singular)
              ..abstractLexicalTraits = (LexicalTraits()
                ..shoresh = (Shoresh()
                  ..root = "דבר"
                  ..weak = false)
                ..grammaticalState = GrammaticalState.absolute),
          ],
        ),
        Dict(
          word: "ו",
          origin: Origin.native,
          stage: Stage.biblical,
          assinatures: [
            Assinatures()
              ..categoricalTraits =
                  [0, 0, 0] // mod / connector
              ..internalMorphologicalTraits = null
              ..abstractLexicalTraits = (LexicalTraits()
                ..shoresh = null
                ..grammaticalState = null),
          ],
        ),
        Dict(
          word: "ה",
          origin: Origin.native,
          stage: Stage.biblical,
          assinatures: [
            Assinatures()
              ..categoricalTraits =
                  [0, 0, 1] // modifier
              ..internalMorphologicalTraits = null
              ..abstractLexicalTraits = (LexicalTraits()
                ..shoresh = null
                ..grammaticalState = null),
          ],
        ),
        Dict(
          word: "ב",
          origin: Origin.native,
          stage: Stage.biblical,
          assinatures: [
            Assinatures()
              ..categoricalTraits =
                  [0, 0, 1] // connector
              ..internalMorphologicalTraits = null
              ..abstractLexicalTraits = (LexicalTraits()
                ..shoresh = null
                ..grammaticalState = null),
          ],
        ),
        Dict(
          word: "ל",
          origin: Origin.native,
          stage: Stage.biblical,
          assinatures: [
            Assinatures()
              ..categoricalTraits =
                  [0, 0, 1] // connector
              ..internalMorphologicalTraits = null
              ..abstractLexicalTraits = (LexicalTraits()
                ..shoresh = null
                ..grammaticalState = null),
          ],
        ),
        Dict(
          word: "את",
          origin: Origin.native,
          stage: Stage.biblical,
          assinatures: [
            Assinatures()
              ..categoricalTraits =
                  [0, 0, 1] // connector / functional particle
              ..internalMorphologicalTraits = null
              ..abstractLexicalTraits = (LexicalTraits()
                ..shoresh = null
                ..grammaticalState = null),
          ],
        ),
        Dict(
          word: "י",
          origin: Origin.native,
          stage: Stage.biblical,
          assinatures: [
            Assinatures()
              ..categoricalTraits =
                  [0, 0, 0] // não ref, não pred, não mod
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..person = Person.third
                ..number = Number.singular
                ..gender = Gender.masculine
                ..tense = VerbForm
                    .imperfect // ou imperfective
                    )
              ..abstractLexicalTraits = (LexicalTraits()
                ..shoresh = null
                ..grammaticalState = null),
          ],
        ),
      ];
      dictLenght = words.length;
      await isar.dicts.putAll(words);
    });

    return true;
  }

  Future<bool> _createLexicalSense() async {
    await isar.writeTxn(() async {
      List<LexicalSense> senses = [
        LexicalSense(
          // senseKey: "WRITE_VERB",
          // semanticType: "EVENT",
          lemmaPt: "escrever",
          type: SemanticType.event,
        ),
        LexicalSense(
          // senseKey: "MOSHE_NOUN",
          // semanticType: "NOUN",
          lemmaPt: "Moshe",
          type: SemanticType.entity,
        ),
        LexicalSense(
          // senseKey: "SEFER_NOUN",
          // semanticType: "NOUN",
          lemmaPt: "livro",
          type: SemanticType.entity,
        ),
        LexicalSense(lemmaPt: "que", type: SemanticType.entity),
        LexicalSense(lemmaPt: "dado", type: SemanticType.event),
        LexicalSense(lemmaPt: "lider", type: SemanticType.entity),
        LexicalSense(lemmaPt: "filhos", type: SemanticType.entity),
        LexicalSense(lemmaPt: "israel", type: SemanticType.entity),
        LexicalSense(lemmaPt: "deserto", type: SemanticType.entity),
      ];
      senseLenght = senses.length;
      await isar.lexicalSenses.putAll(senses);
    });

    return true;
  }

  Future<bool> _createDictSenseLink() async {
    await isar.writeTxn(() async {
      List<DictSenseLink> links = List.generate(
        senseLenght!,
        (index) => DictSenseLink(
          dictId: index,
          lexicalSenseId: index,
          indexAssinature: 0,
        ),
      );
      isar.dictSenseLinks.putAll(links);
    });

    return true;
  }

  Future<void> build() async {
    await initializeIsar();

    print("cleaning Isar ... \n"); 
    await isar.writeTxn(() async => await isar.clear()); // when needed, to reset the db

    await Future.wait([_createDict(), _createLexicalSense()]);
    await _createLexicalSense();

    print("Creating Links...\n");
    await _createDictSenseLink();

    print("Repo is ready. \n");

    // _createLexicalSense();
  }
}
