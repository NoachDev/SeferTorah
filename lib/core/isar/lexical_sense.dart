import 'package:isar/isar.dart';
import 'package:sefertorah/core/models/dictionaries.dart';

part 'lexical_sense.g.dart';

@collection
class LexicalSense {
  Id id = Isar.autoIncrement;

  @Enumerated(EnumType.name)
  late SemanticType type;
  
  late String lemmaPt;         // escrever
  String? lemmaPtCommentary;

  LexicalSense({
    required this.lemmaPt,
    required this.type,
    this.lemmaPtCommentary,
  });
}