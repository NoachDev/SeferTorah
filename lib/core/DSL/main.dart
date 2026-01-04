import 'package:sefertorah/core/DSL/rules.dart';
import 'package:sefertorah/core/isar/dictionaries.dart';
import 'package:vector_math/vector_math.dart';

/// The minimal information for classify an word
///
///```dart
/// final ctx = MorphContext(
///     cat: Vector3(1, 0, 0), // ref
///     gender: Gender.masculine,
///     hasShoresh: false, // pronome ou nome nuclear
/// );
/// print(classifier.classify(ctx));
/// ```
///
class MorphContext {
  final Vector3 cat; // ref, pred, mod
  final Gender? gender;
  final Binyan? binyan;
  final Mishkal? mishkal;
  final GrammaticalState? state;
  final bool hasShoresh;

  MorphContext({
    required this.cat,
    this.gender,
    this.binyan,
    required this.hasShoresh,
    this.mishkal,
    this.state,
  });
}

class MorphClassifier {
  final List<Rule> rules;

  MorphClassifier(this.rules);

  String classify(MorphContext ctx) {
    for (final r in rules) {
      if (r.when(ctx)) {
        return r.then(ctx);
      }
    }
    return 'Undefined';
  }
}

bool isPronounLike(MorphContext d) {
  return !d.hasShoresh &&
      d.mishkal == null &&
      !acceptsArticle(d) &&
      !acceptsConstruct(d);
}

// Verbs, Particles and prons not accpt articles
bool acceptsArticle(MorphContext d) {
  if (d.binyan != null) return false;
  if (!d.hasShoresh && d.mishkal == null) {
    return false; // pronomes e partículas
  }
  return true;
}

/// Verify if the GrammaticalState of the word 
bool acceptsConstruct(MorphContext d) {
  return d.state == GrammaticalState.construct;
}

bool acceptsModifier(MorphContext d) {
  return d.cat.x > 0;
}

/// A clssification in Protugues
final classifier = MorphClassifier([
  // VERBO
  rule().when((c) => c.cat.y > 0 && c.binyan != null).then((_) => 'Verbo'),

  // PREDICADOR NÃO VERBAL (ex.: יֵשׁ)
  rule()
      .when((c) => c.cat.y > 0 && c.cat.x == 0 && c.binyan == null)
      .then((_) => 'Predicador'),

  // FORMA HÍBRIDA (particípio etc.)
  rule()
      .when((c) => c.cat.x > 0 && c.cat.y > 0 && c.mishkal != null)
      .then((c) => 'Forma verbal nominalizada ${_genderPt(c.gender)}'),

  // ADJETIVO
  rule()
      .when((c) => c.cat.z > 0 && c.mishkal != null && c.hasShoresh && c.binyan == null && !acceptsConstruct(c))
      .then((c) => "Adjetivo"),

  rule()
      .when((c) => c.cat.x > 0 && isPronounLike(c))
      .then((c) => 'Pronome ${_genderPt(c.gender)}'),

  // MODIFICADOR
  rule()
      .when((c) => c.cat.z > 0 && c.cat.x == 0 && c.cat.y == 0 && c.mishkal == null && !c.hasShoresh)
      .then((_) => 'Modificador'),

  // SUBSTANTIVO (inclui pronomes por convenção)
  rule()
      .when((c) => c.cat.x > 0)
      .then((c) => 'Substantivo ${_genderPt(c.gender)}'),
  rule()
      .when((c) => c.cat.x == 0 && c.cat.y == 0 && c.cat.z == 0)
      .then((_) => 'Partícula gramatical'),
]);

String _genderPt(Gender? g) {
  if (g == null) return '';
  return g == Gender.masculine ? 'Masculino' : 'Feminino';
}
