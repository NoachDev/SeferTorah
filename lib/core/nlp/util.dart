import 'package:sefertorah/core/isar/dictionaries.dart';
import 'package:sefertorah/core/isar/signatures.dart';
import 'package:sefertorah/core/models/dictionaries.dart';

/// TODO : implement functions in syntax_builder

bool isPronounLike(Signature d, Shoresh? shoresh) {
  return d.internalMorphologicalTraits?.person != null &&
      shoresh == null &&
      d.internalMorphologicalTraits?.mishqal == null &&
      !acceptsArticle(d, shoresh) &&
      !acceptsConstruct(d);
}

// Verbs, Particles and prons not accpt articles
bool acceptsArticle(Signature d, Shoresh? shoresh) {
  if (d.internalMorphologicalTraits?.binyan == null) return false;
  if (shoresh == null &&
      d.internalMorphologicalTraits?.mishqal == null) {
    return false;
  }
  return true;
}

/// Verify the GrammaticalState of the word
bool acceptsConstruct(Signature d) {
  return d.abstractLexicalTraits?.grammaticalState ==
      GrammaticalState.construct;
}

bool acceptsModifier(Signature d) {
  return d.categoricalTraits[0] > 0;
}

bool isOrdinalLike(Signature d, Shoresh? shoresh) {
  /// needed traits
  if (d.internalMorphologicalTraits?.mishqal == null ||
      shoresh == null ||
      d.internalMorphologicalTraits?.gender == null ||
      d.abstractLexicalTraits?.grammaticalState != GrammaticalState.absolute) {
    return false;
  }

  /// uneeded traits
  if (d.internalMorphologicalTraits?.binyan != null) {
    return false;
  }

  return true;
}

bool isCardinalLike(Signature d, Shoresh? shoresh) {
  /// needed traits
  if (shoresh == null ||
      d.abstractLexicalTraits?.grammaticalState != GrammaticalState.absolute) {
    return false;
  }

  /// uneeded traits
  if (d.internalMorphologicalTraits?.mishqal != null ||
      d.internalMorphologicalTraits?.binyan != null) {
    return false;
  }

  return true;
}
