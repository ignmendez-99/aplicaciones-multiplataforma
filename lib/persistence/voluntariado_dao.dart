import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/voluntariado.dart';

class VoluntariadoDao {

  final FirebaseFirestore _firestoreInstance;

  VoluntariadoDao(FirebaseFirestore firebaseFirestore )
  : _firestoreInstance = firebaseFirestore;

  Future<List<Voluntariado>> getAllVoluntariados() async {
    QuerySnapshot querySnapshot = await _firestoreInstance.collection('voluntariados').get();
    List<DocumentSnapshot> documents = querySnapshot.docs;

    List<Voluntariado> voluntariados = [];
    for (DocumentSnapshot document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      voluntariados.add(Voluntariado.fromJson(
        id: document.reference.id,
        json: data
      ));
    }
    return voluntariados;
  }

  Future<Voluntariado?> getVoluntariadoById(String id) async {
    DocumentSnapshot snapshot = await _firestoreInstance
        .collection('voluntariados')
        .doc(id)
        .get();
    if(!snapshot.exists) {
      return null;
    }
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Voluntariado.fromJson(
      id: snapshot.reference.id,
      json: data
    );
  }

  Future<List<Voluntariado>> getVoluntariadosFilteredByName({required String titleFilter}) async {
    QuerySnapshot querySnapshot = await _firestoreInstance
        .collection('voluntariados')
        .where('titulo', isEqualTo: titleFilter)
        .get();
    List<DocumentSnapshot> documents = querySnapshot.docs;

    List<Voluntariado> voluntariados = [];
    for (DocumentSnapshot document in documents) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      voluntariados.add(Voluntariado.fromJson(id: document.reference.id, json: data));
    }
    return voluntariados;
  }

  Future<void> changePostulacionToVoluntariado({
    required bool postularse,
    required int currentVacantes,
    required String voluntariadoId,
    required String userId
  }) async {
    final Map<Object,Object> params = {
      'vacantes': postularse ? currentVacantes - 1 : currentVacantes + 1,
      'postulados': postularse ?
          FieldValue.arrayUnion([userId])
          :
          FieldValue.arrayRemove([userId])
    };
    if(!postularse) {
      params.putIfAbsent('aceptados', () => FieldValue.arrayRemove([userId]));
    }
    await _firestoreInstance
        .collection('voluntariados')
        .doc(voluntariadoId)
        .update(params);
  }

}