import 'dart:io';

import 'package:aplicaciones_multiplataforma/persistence/user_dao.dart';
import 'package:aplicaciones_multiplataforma/services/picture_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UserService with ChangeNotifier {

  static UserService? _instance;

  UserService._(); // Private constructor

  factory UserService() {
    if (_instance == null) {
      _instance = UserService._();
    }
    return _instance!;
  }

  final UserDao _userDao = UserDao(FirebaseFirestore.instance);
  final PictureService _pictureService = PictureService();

  Future<User> getUserById(String id) async {
    return await _userDao.getUserById(id);
  }

  Future<User> createUser({
    required String email,
    required bool emailVerified,
    required String firstName,
    required String lastName,
    required String userId,
  }) async {
    return await _userDao.createUser(
      email: email,
      firstName: firstName,
      lastName: lastName,
      emailVerified: emailVerified,
      userId: userId
    );
  }

  Future<void> updateUser({
    String? phone,
    String? email,
    String? gender,
    DateTime? birthdate,
    required String userId,
    File? profilePicture,
  }) async {
    String? profilePictureDownloadUrl;
    if(profilePicture != null) {
      final String pictureFileName = '$userId-profile-pic';
      profilePictureDownloadUrl = await _pictureService.savePicture(
        fileName: pictureFileName,
        imageFile: profilePicture
      );
    }
    return await _userDao.updateUser(
      userId: userId,
      phone: phone,
      email: email,
      gender: gender,
      birthdate: birthdate,
      profilePictureDownloadUrl: profilePictureDownloadUrl
    );
  }

  Future<void> changeFavouriteInVoluntariado({
    required String voluntariadoId,
    required bool changeTo,
    required userId,
  }) async {
    return await _userDao.changeFavouriteInVoluntariado(
      voluntariadoId: voluntariadoId,
      userId: userId,
      changeTo: changeTo
    );
  }
}