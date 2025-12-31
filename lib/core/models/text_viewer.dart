import 'package:flutter/material.dart' show Color, Colors;

interface class BooksController {
  final List<String> booksName;
  final List<Color> colors;
  final Map<int, int?>? pagesInBook;
  final Map<int, int?>? versesInPage;

  BooksController(
    this.booksName,
    this.colors,
    this.pagesInBook,
    this.versesInPage,
  );

  @Deprecated('only for tests')
  factory BooksController.initial() => BooksController(
    const ["Devarim"],
    [Colors.lightBlue.shade100],
    null,
    null,
  );
}