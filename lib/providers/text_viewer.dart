
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sefertorah/core/isar/repositories.dart';

class _BookMetaData extends AsyncNotifier<Map> with RepositoryOfBooks {
  _BookMetaData(String bookName) : super(){
    name = bookName;
  }
  
  @override
  Future<Map> build() async{
    await conteinsBook();
    return getMetaData();
  }
}

final booksMetaData = AsyncNotifierProvider.family<_BookMetaData, Map, String>(_BookMetaData.new);
