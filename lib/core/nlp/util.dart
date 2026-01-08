import 'package:sefertorah/core/isar/dictionaries.dart';
import 'package:sefertorah/core/models/dictionaries.dart';

bool isPronounLike(Signature d) {
  return d.internalMorphologicalTraits?.person != null &&
      d.abstractLexicalTraits?.shoresh == null &&
      d.internalMorphologicalTraits?.mishqal == null &&
      !acceptsArticle(d) &&
      !acceptsConstruct(d);
}

// Verbs, Particles and prons not accpt articles
bool acceptsArticle(Signature d) {
  if (d.internalMorphologicalTraits?.binyan == null) return false;
  if (d.abstractLexicalTraits?.shoresh == null &&
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

bool isOrdinalLike(Signature d) {
  /// needed traits
  if (d.internalMorphologicalTraits?.mishqal == null ||
      d.abstractLexicalTraits?.shoresh == null ||
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

bool isCardinalLike(Signature d) {
  /// needed traits
  if (d.abstractLexicalTraits?.shoresh == null ||
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
