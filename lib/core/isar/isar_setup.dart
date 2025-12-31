import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'books.dart';

late final Isar isar;

Future<void> initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [BookSchema],
    directory: dir.path,
  );
}
