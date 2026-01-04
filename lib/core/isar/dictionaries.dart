import 'package:isar/isar.dart';

part 'dictionaries.g.dart';

enum Binyan { qal, nifal, piel, pual, hifil, hufal, hitpael }

enum Number { plural, singular, dual }

enum Gender { masculine, feminine, neutral }

enum VerbForm { perfect, imperfect, participle, infinitive, imperative }

enum Person { first, second, third }

enum MishkalType { verbal, nominal }

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
  VerbForm? tense;

  @Enumerated(EnumType.name)
  Person? person;
}

enum Origin { native, aramaic, modern }

enum Stage { biblical, mishnaic, medieval, modern }

enum GrammaticalState { absolute, construct, suffixState }

@embedded
class Shoresh {
  late String root;
  late int radicalCount;
  late bool weak;
}

@embedded
interface class LexicalTraits {
  @Enumerated(EnumType.name)
  late Origin origin;

  @Enumerated(EnumType.name)
  late Stage stage;

  Shoresh? shoresh;

  @Enumerated(EnumType.name)
  GrammaticalState? grammaticalState;
}

@collection
interface class Dict {
  Id id = Isar.autoIncrement;

  late String word;

  late List<byte> categoricalTraits; // is a 3d vector
  late MorphologicalTraits? internalMorphologicalTraits;
  late LexicalTraits abstractLexicalTraits;
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
