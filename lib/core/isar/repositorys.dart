import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:sefertorah/core/isar/books.dart';
import 'package:sefertorah/core/isar/isar_setup.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

/// Controll of Schema Books from DB isar
///
/// by param [name] - A field of collection / document
mixin class RepositoryOfBooks {
  late String name;
  late String fireId;
  late int isarId;

  // RepositoryOfBooks(this.name);

  Future<Book?> _getBook() => isar.books.filter().nameEqualTo(name).findFirst();

  /// Get chapter from book with [name]
  ///
  /// identify if the index are in range of an chapter
  Future<ChaptersMetaData?> getChapterByIndex(Book? isarBook, int index) async {
    isarBook ??= await isar.books.get(isarId);

    return isarBook?.chapters.where((value) {
      if (value.range![0] <= index && value.range![1] >= index) {
        return true;
      }
      return false;
    }).first;
  }

  /// Get the meta datas from the book with [name]
  ///
  /// The key zero is the Chpters mata data,
  /// The key one is the pages meta data
  Future<Map<byte, dynamic>> getMetaData() async {
    var isarBook = await isar.books.get(isarId);

    if (isarBook != null) {
      return {0: isarBook.chapters, 1: isarBook.pagesMetaData};
    }

    throw ErrorDescription("Not find the book \$ $isarId in isar");
  }

  /// Get from isar a page from book with [name]
  ///
  /// if not found in isar, serach in firebase
  Future<PageData?> getPageData(int index) async {
    var isarbook = await _getBook();

    if (isarbook != null) {
      if (index >= isarbook.pages.length) {
        return isarbook.pages[index];
      }

      var chapter = await getChapterByIndex(isarbook, index);

      QuerySnapshot<Map<String, dynamic>> firePageSnapshot = await _db
          .collection("Books")
          .doc(fireId)
          .collection(chapter!.name!) // chapter
          .where("index", isEqualTo: index) // page
          .get();

      Map<String, dynamic> pageData = firePageSnapshot.docs.first.data()
        ..remove("index");

      var page = pageData as PageData;

      await isar.writeTxn(() async {
        isarbook.pages.add(page);
        await isar.books.put(isarbook);
      });

      return page;
    }

    throw ErrorDescription("Not find the book in isar");
  }

  Future<bool> conteinsBook() async {
    var isarBook = await _getBook();

    if (isarBook != null) {
      isarId = isarBook.id;
      return true;
    }

    QuerySnapshot<Map<String, dynamic>> fireBookSnapshot = await _db
        .collection("Books")
        .where("name", isEqualTo: name)
        .get();

    if (fireBookSnapshot.docs.isEmpty) {
      throw ErrorDescription("Not find the book in firebase");
    }

    var fireBook = fireBookSnapshot.docs.first;
    var fireBookData = fireBook.data();

    fireId = fireBook.id;

    List<dynamic> chapters = fireBookData["Chapters"];

    // create a "empty" ( without Data ) book
    await isar.writeTxn(() async {
      var book = Book(
        name: name,
        chapters: chapters.map<ChaptersMetaData>((value) {
          List range = value["range"];
          var name = value["name"] as String;

          return ChaptersMetaData(name: name, range: range.cast<int>());
        }).toList(),
        pages: [],
        pagesMetaData: fireBookData.containsKey("lenght")
            ? List.generate(
                fireBookData["lenght"],
                (index) => "Pagina : ${index + 1}", // default name
              )
            : fireBookData["pages"], // custom name
        // pages: [],
        // pagesMetaData: [],
      );
      await isar.books.put(book);
      isarId = book.id;
    });

    return true;
  }
}
