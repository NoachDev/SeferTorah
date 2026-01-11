import 'package:sefertorah/core/isar/dictionaries.dart';
import 'package:sefertorah/core/models/dictionaries.dart';
import 'package:sefertorah/core/nlp/util.dart';

typedef Condition = bool Function(Signature);
typedef Action = MorphologicalCategory Function(Signature);

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

final List<Rule> rules = [
  // categoricalTraits = [x - 0, y - 1, z - 2 ] = ( ref, pred, mod ) ∈ {0,1}^3
 
  rule()
      .when(
        (c) =>
            c.categoricalTraits[1] > 0 &&
            c.categoricalTraits[0] == 0 &&
            c.internalMorphologicalTraits?.binyan != null,
      )
      .then(
        (c) => MorphologicalCategory(
          category: MorphologicalCategories.verb,
        ),
      ),

  rule()
      .when(
        (c) =>
            c.categoricalTraits[2] > 0 &&
            c.internalMorphologicalTraits?.mishqal != null &&
            c.abstractLexicalTraits?.shoresh != null &&
            c.internalMorphologicalTraits?.binyan == null &&
            !acceptsConstruct(c),
      )
      .then(
        (c) =>
            MorphologicalCategory(category: MorphologicalCategories.adjective),
      ),

  rule()
      .when((c) => c.categoricalTraits[0] > 0 && isPronounLike(c))
      .then(
        (c) => MorphologicalCategory(
          category: MorphologicalCategories.pronoun,
          decorations: {c.internalMorphologicalTraits?.gender},
        ),
      ),

  rule()
      .when((c) => c.categoricalTraits[0] > 0 && isOrdinalLike(c))
      .then(
        (c) => MorphologicalCategory(
          category: MorphologicalCategories.numeral,
          decorations: {NumeralType.ordinal},
        ),
      ),

  rule()
      .when((c) => c.categoricalTraits[2] > 0 && isCardinalLike(c))
      .then(
        (c) => MorphologicalCategory(
          category: MorphologicalCategories.numeral,
          decorations: {NumeralType.cardinal},
        ),
      ),

  /// TODO : Need do more rules
  
  rule()
      .when((c) => c.categoricalTraits[0] > 0)
      .then(
        (c) => MorphologicalCategory(
          category: MorphologicalCategories.noun,
          decorations: {c.internalMorphologicalTraits?.gender},
        ),
      ),
  
  /// TODO : The particles need one rule sophisticated 
  rule()
      .when((c) => true)
      .then(
        (_) =>
            MorphologicalCategory(category: MorphologicalCategories.particle),
      ),
];
