import 'package:sefertorah/core/models/dictionaries.dart';
import 'package:sefertorah/core/nlp/dsl.dart';

typedef Condition = bool Function(MorphContext);
typedef Action = String Function(MorphContext);

RuleBuilder rule() => RuleBuilder();

class Rule {
  final Condition when;
  final Action then;

  Rule({required this.when, required this.then});
}

class RuleBuilder {
  late Condition _condition;

  RuleBuilder when(Condition c) {
    _condition = c;
    return this;
  }

  Rule then(Action a) {
    return Rule(when: _condition, then: a);
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
