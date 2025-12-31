import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sefertorah/providers/global.dart';
import 'package:sefertorah/widgets/home/bottom_sheet.dart';

class _BooksHub extends Notifier<Map<String, dynamic>> {
  // BooksHub() : super({});
  @override
  Map<String, dynamic> build() => {};

  String? _collectionId;
  String? get collectionId => _collectionId;

  bool get showbooks => state.isNotEmpty;

  void setBooks(Map<String, dynamic> books, String id) {
    state = books;
    _collectionId = id;

    if (books.isNotEmpty) {
      ref.read(extendedController.notifier).show(ListBooks(books: books));
    } else {
      ref.read(extendedController.notifier).hide();
    }
  }

  void resetBooks() {
    ref.read(extendedController.notifier).hide();
    state = {};
    _collectionId = null;
  }
}

final booksProvider = NotifierProvider.autoDispose<_BooksHub, Map<String, dynamic>>(
  () => _BooksHub(),
);
