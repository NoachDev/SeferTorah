import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:sefertorah/core/isar/books.dart';
import 'package:sefertorah/core/isar/dictionaries.dart';
import 'package:sefertorah/core/isar/isar_setup.dart';
import 'package:sefertorah/core/isar/lexical_sense.dart';
import 'package:sefertorah/core/nlp/dsl.dart';
import 'package:sefertorah/core/nlp/util.dart';
import 'package:sefertorah/core/nlp/syntax_builder.dart';
import 'package:vector_math/vector_math.dart';

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

  Future<List<List<String>>> _tranfromRefs(
    Book? isarBook,
    PageData data,
  ) async {
    isarBook ??= await isar.books.get(isarId);

    return List.empty();
  }

  /// Get from isar a page with [index] from book with [name]
  ///
  /// if not found in isar, serach in firebase
  ///
  /// The Page is a colection ( list of list ) of refrences ( Strings ),
  ///  reference will in end locate a object in dictionary
  ///
  Future<List<List<String>>?> getPageData(int index) async {
    var isarbook = await _getBook();

    if (isarbook != null) {
      if (index >= isarbook.pages.length) {
        return _tranfromRefs(isarbook, isarbook.pages[index]);
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

      return _tranfromRefs(isarbook, page);
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

class RepositoryOfLexicalSenses {
  Future<LexicalSense?> getById(int dictId, int index) async {
    var link = await isar.dictSenseLinks
        .filter()
        .dictIdEqualTo(dictId)
        .and()
        .indexAssinatureEqualTo(index)
        .findFirst();

    if (link == null) {
      // throw ErrorDescription(
      //   "Not find the LexicalSense link for dictId: $dictId and assinature index: $index",
      // );
      return null;
    }

    return isar.lexicalSenses.get(link.lexicalSenseId);
  }
}

class RepositoryOfDictionaries {
  // Future<MorphReading> getMorphReading(
  //   Dict dict,
  //   int assinatureIndex,
  //   double confidence,
  // ) async {
  //   var ctx = getMorphContext(dict, assinatureIndex);
  //   var morphClass = classifierProjection.classify(ctx);
  //   var sense = await RepositoryOfLexicalSenses().getById(
  //     dict.id,
  //     assinatureIndex,
  //   );

  //   return MorphReading(ctx, morphClass, sense, confidence);
  // }

  // MorphContext getMorphContext(Dict dict, int assinatureIndex) {
  //   var assinature = dict.signatures[assinatureIndex];

  //   var catVector = Vector3(
  //     assinature.categoricalTraits[0].toDouble(),
  //     assinature.categoricalTraits[1].toDouble(),
  //     assinature.categoricalTraits[2].toDouble(),
  //   );

  //   return MorphContext(
  //     cat: catVector,
  //     gender: assinature.internalMorphologicalTraits?.gender,
  //     binyan: assinature.internalMorphologicalTraits?.binyan,
  //     hasShoresh: assinature.abstractLexicalTraits.shoresh != null,
  //     mishkal: assinature.internalMorphologicalTraits?.mishqal,
  //     state: assinature.abstractLexicalTraits.grammaticalState,
  //     form: assinature.internalMorphologicalTraits?.form,
  //   );
  // }

  List<String> getUrlFromSentence(String sentence) {
    return sentence
        .split("\$")
        .where((part) => part.startsWith("Dict::"))
        .toList();
  }

  String hebrewClened(String word) {
    return word.replaceAll(RegExp(r'[\u0591-\u05C7]'), '');
  }

  Future<Dict> getDictByUrl(String url) async {
    var parts = url.split("::");

    if (parts[0] != "Dict") {
      throw ErrorDescription("Invalid dictionary URL: $url");
    }

    var word = parts[1];
    // var assinatureIndex = int.parse(parts[2]);

    var dict = await isar.dicts
        .filter()
        .wordEqualTo(hebrewClened(word))
        .findFirst();

    if (dict == null) {
      throw ErrorDescription(
        "Dictionary not found for word: $word - ${hebrewClened(word)}",
      );
    }

    // if (assinatureIndex < 0 || assinatureIndex >= dict.assinatures.length) {
    //   throw ErrorDescription(
    //     "Assinature index out of range: $assinatureIndex for dict with: $word",
    //   );
    // }

    return dict;
  }
}
