import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

Future<List<Map<dynamic, dynamic>>> repositoryVertex(String? father) async {
  late Query<Map<String, dynamic>> query;

  if (father != null) {
    query = _db.collection("Vertexes").where("details", arrayContains: father);
  } else {
    query = _db.collection("Vertexes").where("tag", isEqualTo: "treeHead");
  }

  QuerySnapshot<Map<String, dynamic>> vertexesSnapshot = await query.get();

  return vertexesSnapshot.docs.map((doc) {
    final data = doc.data();

    return {
      "id": data["name"],
      "tag": "all",
      "data": data["details"] ?? [],
      "tags": data["group"] == null
          ? List<String>.empty()
          : ["index${data["group"]}"],
    };
  }).toList();
}

final getVertexes = FutureProvider.autoDispose.family<List<Map>, String?>((
  ref,
  String? father,
) async {
  var vertexes =  await repositoryVertex(father);
  return vertexes;
});

final getEdges = FutureProvider.autoDispose((ref) async {
  final edgesSnapshot = await _db.collection("Edge").get();

  return edgesSnapshot.docs.map((doc) {
    final data = doc.data();

    return {
      'srcId': data["startVertex"],
      'dstId': data["endVertex"],
      "edgeName": doc.id,
      'ranking': DateTime.now().millisecond,
      "solid": true,
    };
  }).toList();
});
