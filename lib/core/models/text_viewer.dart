import 'package:flutter/material.dart' show Color, Colors;

///Controller of books
///
///The controller is blind to data of book such like number of pages, verses, name of book ...
///
///[bookName] is a list of possible books to open.
///[pagesInBook] Enumerate the, possible, pages to open for each book.
///[versesInPage] Enumerate the, possible, verses to open in each page for each book.
///
///about behavior and verification : is made in the viewer
///
class BooksController {
  final List<String> booksName;
  final List<Color> colors;

  Map<int, List<int>?> pagesInBook; // the index of book : the pegas to showed
  final Map<Set, int>? versesInPage; // (book index, page index ) : range ( from zero ) of verses to dipleyed

  int bookPointer = 0;
  int pagePointer = 0;

  String get bookName => booksName[bookPointer];
  int get page => pagesInBook[bookPointer] != null ? pagesInBook[bookPointer]![pagePointer] : pagePointer;


  BooksController(
    this.booksName,
    this.colors,
    this.pagesInBook,
    [this.versesInPage]);

  @Deprecated('only for tests')
  factory BooksController.initial() =>
      BooksController(const ["Devarim"], [Colors.lightBlue.shade100], {0: null});
}
