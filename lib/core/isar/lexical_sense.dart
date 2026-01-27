import 'package:isar/isar.dart';
import 'package:sefertorah/core/models/dictionaries.dart';

part 'lexical_sense.g.dart';

@collection
class LexicalSense {
  Id id = Isar.autoIncrement;

  @Enumerated(EnumType.name)
  final SemanticType type;
  
  final String? lemmaPt;         // escrever
  final String? lemmaPtCommentary;

  LexicalSense({
    required this.type,
    this.lemmaPt,
    this.lemmaPtCommentary,
  });

  factory LexicalSense.fromMap(Map<String, dynamic> map) {
    return LexicalSense(
      type: SemanticType.values.byName(map["type"]),
      lemmaPt: map.containsKey("lemmaPt") ? map["lemmaPt"] : null,
      lemmaPtCommentary: map.containsKey("lemmaPtCommentary") ? map["lemmaPtCommentary"] : null,
    );
  }

  @override
  String toString() {
    return "Snese : $type , $lemmaPt , $lemmaPtCommentary";
  }
}