import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'books.dart';
import 'dictionaries.dart';
import 'lexical_sense.dart';
import 'signatures.dart';

late final Isar isar;

Future<void> initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [
      BookSchema,
      DictSchema,
      LexicalSenseSchema,
      SignatureSchema,
    ],
    directory: dir.path,
  );
}
