import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserDao {

  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  Future<User> getUserById(String id) async {
    DocumentSnapshot snapshot = await _firestoreInstance
        .collection('users')
        .doc(id)
        .get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return User.fromJson(
        id: snapshot.reference.id,
        json: data
    );
  }

  Future<User> createUser(String email, bool emailVerified) async {
    DocumentReference documentRef = await _firestoreInstance.collection('users').add({
      'email': email,
      'email_verified': emailVerified,
      'favourites': []
    });
    DocumentSnapshot snapshot =  await documentRef.get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return User.fromJson(
        id: snapshot.reference.id,
        json: data
    );
  }

  Future<void> changeFavouriteInVoluntariado({
    required String userId,
    required String voluntariadoId,
    required bool changeTo
  }) async {
    await _firestoreInstance
      .collection('users')
      .doc(userId)
      .update({
        'favourites': changeTo ?
            FieldValue.arrayUnion([voluntariadoId])
            : FieldValue.arrayRemove([voluntariadoId]),
      });
  }

}