import 'package:isar/isar.dart';
import 'package:sefertorah/core/models/dictionaries.dart';

part 'dictionaries.g.dart';

@embedded
class Shoresh {
  late String root;
  // late int radicalCount; // == root.length
  late bool weak;

  Shoresh();

  factory Shoresh.fromMap(Map<String, dynamic> map) {
    return Shoresh()
      ..root = map["root"]
      ..weak = map["weak"];
  }
}

@embedded
interface class SurfaceSignature {
  late String surface; // the word with nekudots

  late int indexSense;
  late int indexSignature;

  SurfaceSignature();

  factory SurfaceSignature.fromMap(Map<String, dynamic> map) {
    return SurfaceSignature()
      ..surface = map["surface"]
      ..indexSense = map["indexSense"]
      ..indexSignature = map["indexSignature"];
  }
}

@collection
class Dict {
  Id id = Isar.autoIncrement;

  final String word;

  @Enumerated(EnumType.name)
  final Origin origin;

  @Enumerated(EnumType.name)
  final Stage stage;

  final Shoresh? shoresh;

  List<SurfaceSignature> signatures;

  Dict({
    required this.word,
    required this.origin,
    required this.stage,
    required this.signatures,
    required this.shoresh,
  });

  factory Dict.fromMap(Map<String, dynamic> map) {
    return Dict(
      word: map["word"],
      origin: Origin.values.byName(map["origin"]),
      stage: Stage.values.byName(map["stage"]),
      shoresh: map.containsKey("shoresh") ? Shoresh.fromMap(map["shoresh"]) : null,
      signatures: map.containsKey("signatures")
          ? List<SurfaceSignature>.from(
              map["signatures"].map((elm) => SurfaceSignature.fromMap(elm)),
            )
          : [],
    );
  }
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
