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
        /// Verb
        Dict(
          word: "כתב",
          origin: Origin.native,
          stage: Stage.biblical,
          signatures: [
            Signature()
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

        /// Noun
        Dict(
          word: "משה",
          origin: Origin.native,
          stage: Stage.biblical,
          signatures: [
            Signature()
              ..categoricalTraits = [1, 0, 0]
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..mishqal = (Mishkal()
                  ..pattern = "קֶטֶל"
                  ..type = MishkalType.nominal)
                ..gender = Gender.masculine)
              ..abstractLexicalTraits = null
              ..abstractLexicalTraits = (LexicalTraits()
                ..grammaticalState = null),
          ],
        ),
        Dict(
          word: "ספר",
          origin: Origin.native,
          stage: Stage.biblical,
          signatures: [
            Signature()
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

        /// Pronoun
        Dict(
          word: "אשר",
          origin: Origin.native,
          stage: Stage.biblical,
          signatures: [
            Signature()
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
          signatures: [
            Signature()
              ..categoricalTraits =
                  [0, 1, 0] // pred
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..binyan = Binyan.qal
                ..form = VerbForm.participle
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
          signatures: [
            Signature()
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
          signatures: [
            Signature()
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
          signatures: [
            Signature()
              ..categoricalTraits =
                  [1, 0, 0] // ref
              ..internalMorphologicalTraits = (MorphologicalTraits()
              ..gender = Gender.masculine
              ..number = Number.singular
              ..mishqal = (Mishkal()
                  ..pattern = "קֶטֶל"
                  ..type = MishkalType.nominal) 
              )
              ..abstractLexicalTraits = (LexicalTraits()
                ..shoresh = null
                ..grammaticalState = GrammaticalState.absolute),
          ],
        ),
        Dict(
          word: "מדבר",
          origin: Origin.native,
          stage: Stage.biblical,
          signatures: [
            Signature()
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
          signatures: [
            Signature()
              ..categoricalTraits =
                  [0, 0, 1]
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
          signatures: [
            Signature()
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
          signatures: [
            Signature()
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
          signatures: [
            Signature()
              ..categoricalTraits =
                  [0, 0, 1] // connector
              ..internalMorphologicalTraits = null
              ..abstractLexicalTraits = (LexicalTraits()
                ..shoresh = null
                ..grammaticalState = null),
          ],
        ),

        /// Pronun / Particle
        Dict(
          word: "את",
          origin: Origin.native,
          stage: Stage.biblical,
          signatures: [
            Signature()
              ..categoricalTraits = [0, 0, 0]
              ..abstractLexicalTraits = null
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..gender = Gender.neutral),
            Signature()
              ..categoricalTraits = [1, 0, 0]
              ..abstractLexicalTraits = null
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..gender = Gender.feminine
                ..person = Person.second
                ..number = Number.singular),
          ],
        ),
        Dict(
          word: "י",
          origin: Origin.native,
          stage: Stage.biblical,
          signatures: [
            Signature()
              ..categoricalTraits =
                  [0, 0, 0]
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..person = Person.third
                ..number = Number.singular
                ..gender = Gender.masculine
                ..form = VerbForm
                    .imperfect
                    )
              ..abstractLexicalTraits = (LexicalTraits()
                ..shoresh = null
                ..grammaticalState = null),
          ],
        ),

        // Adjetive
        Dict(
          word: "גדול",
          origin: Origin.native,
          stage: Stage.biblical,
          signatures: [
            Signature()
              ..categoricalTraits = [0, 0, 1]
              ..abstractLexicalTraits = (LexicalTraits()
                ..grammaticalState = GrammaticalState.absolute
                ..shoresh = (Shoresh()
                  ..root = "גדול"
                  ..weak = false))
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..mishqal = (Mishkal()
                  ..pattern = "קֶטֶל"
                  ..type = MishkalType.nominal)
                ..gender = Gender.masculine),
          ],
        ),

        /// Pronoun
        Dict(
          word: "הוא",
          origin: Origin.native,
          stage: Stage.biblical,
          signatures: [
            Signature()
              ..categoricalTraits = [1, 0, 0]
              ..abstractLexicalTraits = null
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..gender = Gender.masculine
                ..person = Person.third
                ..number = Number.singular),
          ],
        ),

        /// Ordinal
        Dict(
          word: "ראשון",
          origin: Origin.native,
          stage: Stage.biblical,
          signatures: [
            Signature()
              ..categoricalTraits = [1, 1, 0]
              ..abstractLexicalTraits = (LexicalTraits()
                ..shoresh = (Shoresh()
                  ..root = "ראשון"
                  ..weak = false)
                ..grammaticalState = GrammaticalState.absolute)
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..gender = Gender.masculine
                ..number = Number.singular
                ..mishqal = (Mishkal()
                  ..pattern = "קֶטֶל"
                  ..type = MishkalType.nominal)),
          ],
        ),

        /// Numeral (cardinal), pronun, noun
        Dict(
          word: "אחד",
          origin: Origin.native,
          stage: Stage.biblical,
          signatures: [
            Signature()
              ..categoricalTraits = [0, 0, 1]
              ..abstractLexicalTraits = (LexicalTraits()..shoresh = (Shoresh()
                ..root = "אחד"
                ..weak = false)..grammaticalState = GrammaticalState.absolute)
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..gender = Gender.masculine
                ..number = Number.singular),

            Signature()
              ..categoricalTraits = [0, 1, 0]
              ..abstractLexicalTraits = null
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..gender = Gender.masculine
                ..number = Number.singular),

            Signature()
              ..categoricalTraits = [1, 0, 0]
              ..abstractLexicalTraits = null
              ..internalMorphologicalTraits = (MorphologicalTraits()
                ..gender = Gender.masculine
                ..number = Number.singular),
          ],
        ),
      ];
      dictLenght = words.length;
      await isar.dicts.putAll(words);
    });

    // ref  = introduces / can be a referent (entity, participant)
    // pred = introduces / can be a predicate (event, property)
    // mod  = It is structurally dependent on another element (it is not a core element).

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
        LexicalSense(lemmaPt: "que", type: SemanticType.property),
        LexicalSense(lemmaPt: "dar", type: SemanticType.event),
        LexicalSense(lemmaPt: "lider", type: SemanticType.entity),
        LexicalSense(lemmaPt: "filhos", type: SemanticType.entity),
        LexicalSense(lemmaPt: "israel", type: SemanticType.entity),
        LexicalSense(lemmaPt: "deserto", type: SemanticType.entity),
        LexicalSense(lemmaPt: "e", type: SemanticType.property),
        LexicalSense(lemmaPt: "o", type: SemanticType.property),
        LexicalSense(lemmaPt: "no", type: SemanticType.property),
        LexicalSense(lemmaPt: "para", type: SemanticType.property),
        LexicalSense(lemmaPt: null, type: SemanticType.gramma),
        LexicalSense(lemmaPt: null, type: SemanticType.gramma),
        LexicalSense(lemmaPt: null, type: SemanticType.gramma),
      ];
      senseLenght = senses.length;
      await isar.lexicalSenses.putAll(senses);
      await isar.lexicalSenses.put(LexicalSense(lemmaPt: "voce", type: SemanticType.entity));
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
      isar.dictSenseLinks.putAll([...links, DictSenseLink(
          dictId: 14,
          lexicalSenseId: 17,
          indexAssinature: 1,
        )]);
    });

    return true;
  }

  Future<void> build() async {
    await initializeIsar();

    // / when needed, to reset or construct the db
    
    print("cleaning Isar ... \n");
    await isar.writeTxn(
      () async => await isar.clear(),
    );

    print("Creating Data ...\n");

    await Future.wait([_createDict(), _createLexicalSense()]);
    await _createDictSenseLink();

    print("Repo is ready. \n");

    // _createLexicalSense();
  }
}
