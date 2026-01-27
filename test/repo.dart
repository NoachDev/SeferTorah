import 'package:sefertorah/core/isar/isar_setup.dart';
import 'package:sefertorah/core/isar/dictionaries.dart';
import 'package:sefertorah/core/isar/lexical_sense.dart';
import 'package:sefertorah/core/isar/signatures.dart';

import 'dart:convert';
import 'dart:io';

class CreateRepo {
  Future<void> _createSignatures() async {
    // final file = File('test/repo/signature.yaml');
    // final yamlString = file.readAsStringSync();
    // final doc = loadYamlDocuments(yamlString);
    final file = File('test/repo/signature.json');
    final jsonString = file.readAsStringSync();
    final List doc = jsonDecode(jsonString);

    await isar.writeTxn(() async {
      isar.signatures.putAll(doc.map((elm) => Signature.fromMap(elm)).toList());
    });
  }

  Future<void> _createDict() async {
    final file = File('test/repo/dict.json');
    final jsonString = file.readAsStringSync();
    final List doc = jsonDecode(jsonString);

    await isar.writeTxn(() async {
      isar.dicts.putAll(doc.map((elm) => Dict.fromMap(elm)).toList());
    });

    // ref  = introduces / can be a referent (entity, participant)
    // pred = introduces / can be a predicate (event, property)
    // mod  = It is structurally dependent on another element (it is not a core element).
  }

  Future<void> _createLexicalSense() async {
    final file = File('test/repo/sense.json');
    final jsonString = file.readAsStringSync();
    final List doc = jsonDecode(jsonString);

    await isar.writeTxn(() async {
      isar.lexicalSenses.putAll(doc.map((elm) => LexicalSense.fromMap(elm)).toList());
    });
    // await isar.writeTxn(() async {
    //   List<LexicalSense> senses = [];
    //   await isar.lexicalSenses.putAll(senses);
    // });
  }

  Future<void> build() async {
    await initializeIsar();

    // / when needed, to reset or construct the db

    print("cleaning Isar ... \n");
    await isar.writeTxn(() async => await isar.clear());

    print("Creating Data ...\n");

    await Future.wait([_createLexicalSense(), _createSignatures(), _createDict()]);

    print("Repo is ready. \n");

    // _createLexicalSense();
  }
}
