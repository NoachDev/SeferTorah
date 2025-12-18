
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

final getVertexes = FutureProvider((ref) async {
    final vertexesSnapshot = await _db.collection("Vertex").get();

    return vertexesSnapshot.docs.map((doc) {
      final data = doc.data();

      return {
        "id": data["name"],
        "tag" : "all",
        "data" : data["details"] ?? [],
        "tags" : data["groups"] ?? List<String>.empty(),
        "solid" : true,
        "scale" : 1.5
        };
    }).toList();

  }
);

final getEdges = FutureProvider((ref) async {
    final edgesSnapshot = await _db.collection("Edge").get();

    return edgesSnapshot.docs.map((doc) {
      final data = doc.data();

      return {
        'srcId': data["startVertex"],
        'dstId': data["endVertex"],
        "edgeName" : doc.id,
        'ranking': DateTime.now().millisecond,
        "solid" : true,
      };
    }).toList();

  }
);
