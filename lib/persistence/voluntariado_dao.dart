import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/voluntariado.dart';

class VoluntariadoDao {

  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  Future<List<Voluntariado>> getAllVoluntariados() async {
    QuerySnapshot querySnapshot = await _firestoreInstance.collection('voluntariados').get();
    List<DocumentSnapshot> documents = querySnapshot.docs;

    List<Voluntariado> voluntariados = [];
    for (DocumentSnapshot document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      voluntariados.add(Voluntariado.fromJson(document.reference.id, data));
    }
    return voluntariados;
  }

  // TODO no anda
  Future<List<Voluntariado>> getVoluntariadosFilteredByName({required String titleFilter}) async {
    QuerySnapshot querySnapshot = await _firestoreInstance
        .collection('voluntariados')
        .where("titulo", isGreaterThanOrEqualTo: titleFilter)
        .where("titulo", isLessThanOrEqualTo: "$titleFilter\uf8ff")
        .get();
    List<DocumentSnapshot> documents = querySnapshot.docs;

    List<Voluntariado> voluntariados = [];
    for (DocumentSnapshot document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      voluntariados.add(Voluntariado.fromJson(document.reference.id, data));
    }
    return voluntariados;
  }

}