import 'package:sefertorah/core/isar/lexical_sense.dart';
import 'package:sefertorah/core/models/dictionaries.dart';
import 'package:sefertorah/core/nlp/rules.dart';
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

class MorphReading {
  final MorphContext ctx;
  final String morphClass;
  final LexicalSense? sense;
  final double confidence;

  MorphReading(this.ctx, this.morphClass, this.sense, this.confidence);

}

