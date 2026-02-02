import 'package:isar/isar.dart';
import 'package:sefertorah/core/models/dictionaries.dart';

part 'dictionaries.g.dart';

@embedded
class Shoresh {
  final String root;
  // late int radicalCount; // == root.length
  final bool weak;

  Shoresh({this.root = "", this.weak = false});

  factory Shoresh.fromMap(Map<String, dynamic> map) {
    return Shoresh(root: map["root"], weak: map["weak"]);
  }
}

@embedded
interface class SurfaceSignature {
  final String surface; // the word with nekudots

  final String indexSense;
  final String indexSignature;

  SurfaceSignature({this.surface = "", this.indexSense = "0", this.indexSignature = "0"});

  factory SurfaceSignature.fromMap(Map<String, dynamic> map) {
    return SurfaceSignature(surface: map["surface"], indexSense: map["idSense"], indexSignature: map["idSignature"]);
  }
}

@collection
class Dict {
  Id id = Isar.autoIncrement;

  final String hash; // firebase id

  final String word;

  @Enumerated(EnumType.name)
  final Origin origin;

  @Enumerated(EnumType.name)
  final Stage stage;

  final Shoresh? shoresh;

  List<SurfaceSignature> signatures;

  Dict({
    required this.hash,
    required this.word,
    required this.origin,
    required this.stage,
    required this.signatures,
    required this.shoresh,
  });

  factory Dict.fromMap(Map<String, dynamic> map) {
    return Dict(
      hash: map["hash"],
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
