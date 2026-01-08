import 'package:isar/isar.dart';
import 'package:sefertorah/core/models/dictionaries.dart';

part 'dictionaries.g.dart';

@embedded
class Mishkal {
  late String pattern;

  @Enumerated(EnumType.name)
  late MishkalType type;
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
}

@embedded
class Shoresh {
  late String root;
  // late int radicalCount; // == root.length
  late bool weak;
}

@embedded
interface class LexicalTraits {

  Shoresh? shoresh;

  @Enumerated(EnumType.name)
  GrammaticalState? grammaticalState;
}

@embedded
interface class Signature {
  // late String signatureId;

  late List<byte> categoricalTraits; // is a 3d vector
  late MorphologicalTraits? internalMorphologicalTraits;
  late LexicalTraits? abstractLexicalTraits;
}

@collection
interface class Dict {
  Id id = Isar.autoIncrement;

  late String word;

  @Enumerated(EnumType.name)
  late Origin origin;

  @Enumerated(EnumType.name)
  late Stage stage;

  late List<Signature> signatures;

  Dict({
    required this.word,
    required this.origin,
    required this.stage,
    required this.signatures,
  });
}


@collection
class DictSenseLink {
  Id id = Isar.autoIncrement;

  late int dictId;
  late int indexAssinature;
  late int lexicalSenseId;

  DictSenseLink({
    required this.dictId,
    required this.indexAssinature,
    required this.lexicalSenseId,
  });
}

///
/// Structural class (𝑺)
/// the set of minimal abstract linguistic structures,
/// such that each structure:
///   - It is independent of syntactic context.
///   - contains only potentially classifiable properties.
///   - corresponds to a possible lexical identity
/// 
/// 𝑺 = { σ ∣ σ = ⟨C,M,L⟩ } | C = ( ref, pred, mod ) ∈ {0,1}^3 " categorical traits " , M = "internal morphological traits", L = "abstract lexical traits"
/// 
/// π: S ⇀ C | C = { " conventional morphological labels " }
/// ∣π(σ)∣ < ∣σ∣
/// 
