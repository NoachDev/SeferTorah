import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sefertorah/core/isar/repositories.dart';

interface class Data {
  final List<String> hebrewTextKeys;
  final List<String> hebrewTextValues;
  final String translatedText;

  Data(this.hebrewTextKeys, this.hebrewTextValues, this.translatedText);
}

class _BookMetaData extends AsyncNotifier<MetaData?> with RepositoryOfBooks {
  @override
  Future<Null> build() async {
    return null;
  }

  void setMetaData(String name) async {
    super.name = name;

    await conteinsBook();
    state = AsyncValue.data(await getMetaData());
  }
}

class _BookPageData extends AsyncNotifier<List<Data>> with RepositoryOfBooks {
  @override
  Future<List<Data>> build() async {
    return [];
  }

  void setPageData(String name, int index, String chapter) async {

    super.name = name;

    await conteinsBook();
    final raw = await getPageData(index, chapter);
    final data = raw.map((elm) async {

      final contrl = RepoOfOneVerse(elm);
      await contrl.buildTokens();
      contrl.buildedSynataxGraph;
      await contrl.buildedSemanticGraph;
      final semantic = contrl.semanticGraphs.first;
      final lin = semantic.linearizationSVO();

      return Data(
        contrl.normSentence.keys.toList(),
        contrl.normSentence.values.toList(),
        lin.join().trim(),
      );
    }).toList();

    state = AsyncValue.data(await Future.wait(data));
  }
}

final booksMetaData =
    AsyncNotifierProvider.autoDispose<_BookMetaData, MetaData?>(
      _BookMetaData.new,
    );

final booksPageData =
    AsyncNotifierProvider.autoDispose<_BookPageData, List<Data>>(
      _BookPageData.new,
    );
