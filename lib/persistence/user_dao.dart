import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserDao {
  final FirebaseFirestore _firestoreInstance;

  UserDao(FirebaseFirestore firestoreInstance)
    : _firestoreInstance = firestoreInstance;

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

  Future<User> createUser({
    required String email,
    required bool emailVerified,
    required String firstName,
    required String lastName,
    required String userId,
  }) async {
    await _firestoreInstance.collection('users').doc(userId).set({
      'email': email,
      'email_verified': emailVerified,
      'favourites': [],
      'user_updated': false,
      'first_name': firstName,
      'last_name': lastName,
    });
    return getUserById(userId);
  }

  Future<void> changeFavouriteInVoluntariado({
    required String userId,
    required String voluntariadoId,
    required bool changeTo
  }) async {
    final Map<Object,Object> params = {
      'favourites': changeTo ?
          FieldValue.arrayUnion([voluntariadoId])
          :
          FieldValue.arrayRemove([voluntariadoId])
    };
    await _firestoreInstance
      .collection('users')
      .doc(userId)
      .update(params);
  }

  Future<void> updateUser({
    String? phone,
    String? email,
    String? gender,
    DateTime? birthdate,
    required String userId,
    String? profilePictureDownloadUrl,
  }) async {
    final Map<Object,Object> params = {};
    if(phone != null) {
      params.putIfAbsent('phone', () => phone);
    }
    if(email != null) {
      params.putIfAbsent('email', () => email);
    }
    if(gender != null) {
      params.putIfAbsent('gender', () => gender);
    }
    if(birthdate != null) {
      params.putIfAbsent('birthdate', () => birthdate);
    }
    if(profilePictureDownloadUrl != null) {
      params.putIfAbsent('profile_picture_download_url', () => profilePictureDownloadUrl);
    }
    if(params.isNotEmpty) {
      params.putIfAbsent('user_updated', () => true);
      await _firestoreInstance
          .collection('users')
          .doc(userId)
          .update(params);
    }
  }

}