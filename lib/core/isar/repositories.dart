import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:sefertorah/core/isar/books.dart';
import 'package:sefertorah/core/isar/dictionaries.dart';
import 'package:sefertorah/core/isar/isar_setup.dart';
import 'package:sefertorah/core/isar/lexical_sense.dart';
import 'package:sefertorah/core/isar/signatures.dart';
import 'package:sefertorah/core/nlp/semantic_builder.dart';
import 'package:sefertorah/core/nlp/syntax_builder.dart';

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

class RepositoryOfDictionaries {
  Future<Signature> getSignById(int id) async {
    final sig = await isar.signatures.get(id);

    if (sig != null) {
      return sig;
    }

    throw ErrorDescription("Not find the signature with id: $id");
  }

  Future<LexicalSense> getSenseById(int id) async {
    var sense = await isar.lexicalSenses.get(id);

    if (sense != null) {
      return sense;
    }

    throw ErrorDescription("Not find the Sense with id: $id");
  }

  List<String> getUrlFromSentence(
    String sentence, [
    bool expanded = true,
    bool includeMarks = false,
  ]) {
    final exp = RegExp(r'\$Group\{(.*?)\}|\$Dict::([^$]*)');
    final matches = exp.allMatches(sentence);

    List<String> ret = [];

    for (var part in matches) {
      if (part[0]!.startsWith(r"$Dict::")) {
        ret.add(part[0]!);
      } else if (includeMarks && part[0]!.startsWith(r"$Mark::")) {
        ret.add(part[0]!);
      } else if (part[0]!.startsWith(r"$Group{") && expanded) {
        ret.addAll(
          getUrlFromSentence(part[0]!.substring(7, part[0]!.length - 1)),
        );
      }
    }

    return ret;
  }

  String hebrewClened(String word) {
    return word.replaceAll(RegExp(r'[\u0591-\u05C7]'), '');
  }

  Future<Dict> getDictByUrl(String url) async {
    var parts = url.split("::");

    if (parts[0] != r"$Dict") {
      throw ErrorDescription("Invalid dictionary URL: $url");
    }

    var id = parts[1];
    // var assinatureIndex = int.parse(parts[2]);
    late int parse;

    try {
      parse = int.parse(id);
    } catch (e) {
      throw ErrorDescription("Invalid dictionary URL: $url");
    }

    var dict = await isar.dicts.get(parse);

    if (dict == null) {
      throw ErrorDescription("Dictionary not found for id: $id");
    }

    // if (assinatureIndex < 0 || assinatureIndex >= dict.assinatures.length) {
    //   throw ErrorDescription(
    //     "Assinature index out of range: $assinatureIndex for dict with: $word",
    //   );
    // }

    return dict;
  }
}

class RepoOfOneVerse extends RepositoryOfDictionaries {
  final syntaxBuilder = SyntaxBuilder();

  final List<SyntaxToken> tokensSentence = [];
  final List<SemanticBuilder> semanticGraphs = [];

  final List<Dict> _cachedDicts = [];
  final String sentence;

  RepoOfOneVerse(this.sentence);

  String? _normSentence;

  String get normSentence => _normSentence ?? _getNormSentence(sentence);

  bool get buildedSynataxGraph {
    if (tokensSentence.isNotEmpty) {
      syntaxBuilder.build(tokensSentence);
      return true;
    }

    return false;
  }

  String _getNormSentence(String sent) {
    final url = getUrlFromSentence(sent, false, true).reversed;

    return url
        .map((String e) {
          if (e.startsWith(r'$Dict')) {
            final parts = e.split("::");
            late int index;

            if (parts.length == 3) {
              index = int.parse(parts[2]);
            } else {
              // TODO: when have more of one projection, the graph define them

              index = 0;
            }

            return _cachedDicts
                .where((val) => val.id == int.parse(parts[1]))
                .first
                .signatures[index]
                .surface;
          } else if (e.startsWith(r'$Mark')) {
            return e.split("::")[1];
          }

          // else if (e.startsWith(r'$Group'))
          final add = _getNormSentence(sent);
          add.replaceAll(" ", "");

          return add;
        })
        .join(" ")
        .trim();
  }

  Future<bool> get buildedSemanticGraph async {
    if (buildedSynataxGraph) {
      for (final state in syntaxBuilder.hypotheses) {
        final senses = <LexicalSense?>[];

        for (final node in state.nodes) {
          final dict = _cachedDicts[node.tokenIndex];
          // the index of projection is the same of index of siginature in dict
          final indexOfSigin = tokensSentence[node.tokenIndex].projections
              .indexOf(node.projection);

          senses.add(
            await getSenseById(dict.signatures[indexOfSigin].indexSense),
          );
        }

        semanticGraphs.add(SemanticBuilder(state, senses));
      }
      return true;
    }

    return false;
  }

  Future<void> buildTokens() async {
    for (var url in getUrlFromSentence(sentence).reversed) {
      final dict = await getDictByUrl(url);
      final parts = url.split("::");

      late List<SyntacticProjection> projections;

      if (parts.length == 3) {
        final sign = await getSignById(
          dict.signatures[int.parse(parts[2])].indexSignature,
        );
        projections = [SyntacticProjection.create(sign)];
      } else {
        projections = await Future.wait(
          dict.signatures.map((surfc) async {
            final sign = await getSignById(surfc.indexSignature);
            return SyntacticProjection.create(sign);
          }),
        );
      }

      tokensSentence.add(
        SyntaxToken(
          index: tokensSentence.length,
          surface: dict.word,
          projections: projections,
        ),
      );

      _cachedDicts.add(dict);
    }
  }
}
