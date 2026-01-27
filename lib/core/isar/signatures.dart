import 'package:isar/isar.dart';
import 'package:sefertorah/core/models/dictionaries.dart';

part 'signatures.g.dart';

@embedded
class Mishkal {
  late String pattern;

  @Enumerated(EnumType.name)
  late MishkalType type;

  Mishkal();

  factory Mishkal.fromMap(Map<String, dynamic> map) {
    return Mishkal()
      ..pattern = map["pattern"]
      ..type = MishkalType.values.byName(map["type"]);
  }
}

@embedded
interface class MorphologicalTraits {
  // Formative;
  @Enumerated(EnumType.name)
  Binyan? binyan;

  @Enumerated(EnumType.name)
  Mishkal? mishqal;

  // Flexionais
  @Enumerated(EnumType.name)
  Number? number;

  @Enumerated(EnumType.name)
  Gender? gender;

  @Enumerated(EnumType.name)
  VerbForm? form;

  @Enumerated(EnumType.name)
  VerbTense? tense;

  @Enumerated(EnumType.name)
  Person? person;

  MorphologicalTraits();

  factory MorphologicalTraits.fromMap(Map<String, dynamic> map) {
    return MorphologicalTraits()
      ..binyan = map.containsKey("binyan")
          ? Binyan.values.byName(map["binyan"])
          : null
      ..mishqal = map.containsKey("mishqal")
          ? Mishkal.fromMap(map["mishqal"])
          : null
      ..form = map.containsKey("form")
          ? VerbForm.values.byName(map["form"])
          : null
      ..gender = map.containsKey("gender")
          ? Gender.values.byName(map["gender"])
          : null
      ..number = map.containsKey("number")
          ? Number.values.byName(map["number"])
          : null
      ..person = map.containsKey("person")
          ? Person.values.byName(map["person"])
          : null
      ..tense = map.containsKey("tense")
          ? VerbTense.values.byName(map["tense"])
          : null;
  }
}

@embedded
interface class LexicalTraits {
  @Enumerated(EnumType.name)
  GrammaticalState? grammaticalState;

  LexicalTraits();

  factory LexicalTraits.fromMap(Map<String, dynamic> map) {
    final ret = LexicalTraits();

    if (map.containsKey("grammaticalState")){
      ret.grammaticalState = GrammaticalState.values.byName(map["grammaticalState"]) ;
    }

    return ret;
  }
}

@collection
class Signature {
  Id id = Isar.autoIncrement;

  List<byte> categoricalTraits; // is a 3d vector
  MorphologicalTraits? internalMorphologicalTraits;
  LexicalTraits? abstractLexicalTraits;

  Signature({
    required this.categoricalTraits,
    this.internalMorphologicalTraits,
    this.abstractLexicalTraits,
  });

  factory Signature.fromMap(Map<String, dynamic> map) {
    return Signature(
      categoricalTraits: List<int>.from(map["categoricalTraits"]),
      internalMorphologicalTraits:
          map.containsKey("internalMorphologicalTraits")
          ? MorphologicalTraits.fromMap(map["internalMorphologicalTraits"])
          : null,
      abstractLexicalTraits: map.containsKey("abstractLexicalTraits")
          ? LexicalTraits.fromMap(map["abstractLexicalTraits"])
          : null,
    );
  }
}
