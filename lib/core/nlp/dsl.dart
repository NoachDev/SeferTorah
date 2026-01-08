import 'package:sefertorah/core/models/dictionaries.dart';
import 'package:sefertorah/core/nlp/rules.dart';
import 'package:sefertorah/core/isar/dictionaries.dart';

class MorphProjection {
  List<Rule>? morphRules;

  MorphProjection({this.morphRules});
  
  MorphologicalCategory classify(Signature ctx) {
    morphRules ??= rules;

    for (final r in morphRules!) {
      if (r.when(ctx)) {
        return r.then(ctx);
      }
    }

    return MorphologicalCategory.empty();
  }
}

// class MorphReading {
//   final MorphContext ctx;
//   final MorphologicalCategory morphClass;
//   final LexicalSense? sense;
//   final double confidence;

//   MorphReading(this.ctx, this.morphClass, this.sense, this.confidence);

// }
