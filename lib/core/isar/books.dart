import 'package:isar/isar.dart';

part 'books.g.dart';

@Collection()
class Book {
  Id id = Isar.autoIncrement;
  final String hash; // fireId

  final String name;

  List<ChaptersMetaData> chapters;
  List<String> pagesMetaData; // Numer of pages | your names
  List<PageData> pages;

  Book({
    required this.hash,
    required this.name,
    required this.chapters,
    required this.pagesMetaData,
    required this.pages,
  });
}

@embedded
interface class ChaptersMetaData {
  String name;
  List<int> range;

  ChaptersMetaData([this.name = "", this.range = const []]);
}

@embedded
interface class PageData {
  List<String> verses;
  PageData([this.verses = const []]);

  factory PageData.fromMap(Map<String, dynamic> map) {
    return PageData(
      List<String>.from(map["verses"]),
    );
  }
}

extension PageDataExtensions on Book {
  ///
  Book withGrowablePages() => this..pages = pages.toList();
}
