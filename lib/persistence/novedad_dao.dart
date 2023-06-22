import 'package:aplicaciones_multiplataforma/models/novedad.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NovedadDao {

  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  Future<List<Novedad>> getAllNovedades() async {
    QuerySnapshot querySnapshot = await _firestoreInstance.collection('novedades').get();
    List<DocumentSnapshot> documents = querySnapshot.docs;

    List<Novedad> novedades = [];
    for (DocumentSnapshot document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      novedades.add(Novedad.fromJson(
          id: document.reference.id,
          json: data
      ));
    }
    return novedades;
  }

  Future<Novedad?> getNovedadById(String id) async {
    DocumentSnapshot snapshot = await _firestoreInstance
        .collection('novedades')
        .doc(id)
        .get();
    if(!snapshot.exists) {
      return null;
    }
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Novedad.fromJson(
        id: snapshot.reference.id,
        json: data
    );
  }
}