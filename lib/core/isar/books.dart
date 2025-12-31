import 'package:isar/isar.dart';

part 'books.g.dart';

@Collection()
interface class Book {
  Id id = Isar.autoIncrement;

  late String name;

  late List<ChaptersMetaData> chapters;
  late List<String>? pagesMetaData; // Numer of pages | your names
  late List<PageData> pages;

  Book( { required this.name, required this.chapters, this.pagesMetaData, required this.pages});
  
}

@embedded
interface class ChaptersMetaData {
  String? name;
  List<int>? range;

  ChaptersMetaData({ this.name, this.range});
}

@embedded
interface class PageData {
  late List<VerseData> verses;

}

@embedded
interface class VerseData {
  late String key;
  late List<String> hebrewWords;
}

