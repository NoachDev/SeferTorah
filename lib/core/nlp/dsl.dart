import 'package:sefertorah/core/isar/dictionaries.dart';
import 'package:sefertorah/core/isar/signatures.dart';
import 'package:sefertorah/core/models/dictionaries.dart';
import 'package:sefertorah/core/nlp/rules.dart';

class MorphProjection {
  List<Rule>? morphRules;

  MorphProjection({this.morphRules});
  
  MorphologicalCategory classify(Signature ctx, Shoresh? shoresh) {
    morphRules ??= rules;

    for (final r in morphRules!) {
      if (r.when(ctx, shoresh)) {
        return r.then(ctx);
      }
    }

    return MorphologicalCategory.empty();
  }
}