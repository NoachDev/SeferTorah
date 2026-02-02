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

/// A interface for "matadata" acquired from RepositoryOfBooks
///
interface class MetaData {
  final List<ChaptersMetaData> chapters;
  final List<String> pagesMetaData;

  MetaData(this.chapters, this.pagesMetaData);

  String getChapter(int index) =>
      chapters
          .where((value) {
            if (value.range[0] <= index && value.range[1] >= index) {
              return true;
            }

            return false;
          })
          .firstOrNull
          ?.name ??
      "Unknown";

  String getPageName(int index) => pagesMetaData[index];
}

/// Controll of Books Schema from DB isar
///
/// by param [name] - A field of collection / document
mixin class RepositoryOfBooks {
  late String name;
  late int isarId;

  /// Get the meta datas from the book with [name]
  ///
  Future<MetaData> getMetaData() async {
    var isarBook = await isar.books.get(isarId);

    return MetaData(isarBook!.chapters, isarBook.pagesMetaData);
  }

  /// Get from isar a page with [index] from book with [name]
  ///
  /// if not found in isar, serach in firebase
  ///
  /// The Page is a colection ( list of list ) of refrences ( Strings ),
  ///  reference will in end locate a object in dictionaries
  ///
  Future<List<String>> getPageData(int index, String chapter) async {
    var isarBook = await isar.books.get(isarId);

    if (index + 1 > isarBook!.pages.length) {
      QuerySnapshot<Map<String, dynamic>> firePageSnapshot = await _db
          .collection("Books")
          .doc(isarBook.hash)
          .collection(chapter) // chapter
          .where("index", isEqualTo: index) // page
          .get();

      if (firePageSnapshot.docs.first.exists) {
        Map<String, dynamic> data = firePageSnapshot.docs.first.data()
          ..remove("index");

        final page = PageData.fromMap(data);

        await isar.writeTxn(() async {
          final book = isarBook.withGrowablePages();
          book.pages.add(page);
          await isar.books.put(book);
        });

        return page.verses;
      }

      throw ErrorDescription("Not find the book in FireBase");
    }

    return isarBook.pages[index].verses;
  }

  /// Get the book from isar.
  ///
  /// When not find in isar, serach in FireStore to crete a local version of it - with empety data (pages).
  ///
  /// And, set background variables like [isarId]
  ///
  Future<bool> conteinsBook() async {
    var isarBook = await isar.books.filter().nameEqualTo(name).findFirst();

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

    List<dynamic> chapters = fireBookData["Chapters"];

    // create a "empty" ( without Data ) book
    await isar.writeTxn(() async {
      var book = Book(
        hash: fireBook.id,
        name: name,
        chapters: chapters.map<ChaptersMetaData>((value) {
          List range = value["range"];
          var name = value["name"] as String;

          return ChaptersMetaData(name, range.cast<int>());
        }).toList(),
        pages: [],
        pagesMetaData: fireBookData.containsKey("lenght")
            ? List.generate(
                fireBookData["lenght"],
                (index) => "Pagina : ${index + 1}", // default name
              )
            : fireBookData["pages"], // custom name
      );
      await isar.books.put(book);
      isarId = book.id;
    });

    return true;
  }
}

/// Controll of Dictionaries Schema from DB isar
///
class RepositoryOfDictionaries {
  Future<Signature> getSignById(String id) async {
    final sign = await isar.signatures.filter().hashEqualTo(id).findFirst();

    if (sign == null) {
      DocumentSnapshot<Map<String, dynamic>> fireSignSnapshot = await _db
          .collection("Signatures")
          .doc(id)
          .get();
      if (fireSignSnapshot.exists) {
        final sign = Signature.fromMap({
          ...fireSignSnapshot.data()!,
          "hash": id,
        });

        await isar.writeTxn(() async {
          await isar.signatures.put(sign);
        });

        return sign;
      }
      throw ErrorDescription("Not find the signature with id: $id");
    }

    return sign;
  }

  Future<LexicalSense> getSenseById(String id) async {
    var sense = await isar.lexicalSenses.filter().hashEqualTo(id).findFirst();

    if (sense == null) {
      DocumentSnapshot<Map<String, dynamic>> fireSenseSnapshot = await _db
          .collection("LexicalSenses")
          .doc(id)
          .get();

      if (fireSenseSnapshot.exists) {
        final sign = LexicalSense.fromMap({
          ...fireSenseSnapshot.data()!,
          "hash": id,
        });

        await isar.writeTxn(() async {
          await isar.lexicalSenses.put(sign);
        });

        return sign;
      }

      throw ErrorDescription("Not find the Sense with id: $id");
    }

    return sense;
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

  ///Fetch from isar or firebase a Dict in url form
  ///
  ///exemple of [url] : $Dict::uuDRmhaYI5qECDx2W2xW
  ///
  ///TODO : get the dict from a reference ( a link to a verse ) e.g. $Ref{book:LPYycCGfwmxa7YoXbtSE,chapter:Devarim,page:0,verse:0}
  Future<Dict> getDictByUrl(String url) async {
    final parts = url.split("::");

    if (parts[0] != r"$Dict") {
      throw ErrorDescription("Invalid dictionary URL: $url");
    }

    final id = parts[1].trim();
    final dict = await isar.dicts.filter().hashEqualTo(id).findFirst();

    if (dict == null) {
      DocumentSnapshot<Map<String, dynamic>> fireDictSnapshot = await _db
          .collection("Dictionaries")
          .doc(id)
          .get();
      

      if (fireDictSnapshot.exists) {
        final dict = Dict.fromMap({...fireDictSnapshot.data()!, "hash": id});

        await isar.writeTxn(() async {
          await isar.dicts.put(dict);
        });

        return dict;
      }

      throw ErrorDescription("Dictionary not found for id: $id");
    }

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

  Map<String, String>? _normSentence;

  Map<String, String> get normSentence =>
      _normSentence ?? _getNormSentence(sentence);

  bool get buildedSynataxGraph {
    if (tokensSentence.isNotEmpty) {
      if (syntaxBuilder.hypotheses.isEmpty) {
        syntaxBuilder.build(tokensSentence);
      }
      
      return true;
    }

    return false;
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

  Map<String, String> _getNormSentence(String sent) {
    final url = getUrlFromSentence(sent, false, true).reversed;

    return Map.fromEntries(
      url.map((String e) {
        if (e.startsWith(r'$Dict')) {
          final parts = e.split("::");
          late int index;

          if (parts.length == 3) {
            index = int.parse(parts[2]);
          } else {
            // TODO: when have more of one projection, the graph define them

            index = 0;
          }

          final dict = _cachedDicts
              .where((val) => val.hash == parts[1])
              .first;

          return MapEntry(
            dict.signatures[index].surface,
            semanticGraphs
                .first
                .graph
                .nodes[_cachedDicts.indexOf(dict)]
                .sense
                .lemmaPt,
          );
        } else if (e.startsWith(r'$Mark')) {
          return MapEntry(e.split("::")[1], "");
        }

        // else if (e.startsWith(r'$Group')){
        final add = _getNormSentence(sent);
        return MapEntry(add.keys.join().trim(), add.values.join(" ".trim()));
        // }
      }),
    );
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
