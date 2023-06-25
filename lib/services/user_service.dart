import 'dart:io';

import 'package:aplicaciones_multiplataforma/persistence/user_dao.dart';
import 'package:aplicaciones_multiplataforma/services/picture_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final UserDao _userDao = UserDao();
  final PictureService _pictureService = PictureService();

  Future<SerManosUser> getUserById(String id) async {
    return await _userDao.getUserById(id);
  }

  Future<SerManosUser> createUser({
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

  Future<Map<String, String>> updateUser({
    String? phone,
    String? email,
    String? gender,
    DateTime? birthdate,
    required String userId,
    File? profilePicture,
  }) async {
    try {
      String? profilePictureDownloadUrl;
      if(profilePicture != null) {
        final String pictureFileName = '$userId-profile-pic';
        profilePictureDownloadUrl = await _pictureService.savePicture(
            fileName: pictureFileName,
            imageFile: profilePicture
        );
      }
      if(email != null) {
        try {
          await FirebaseAuth.instance.currentUser!.updateEmail(email);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'email-already-in-use') {
            return {'result': 'error', 'detail': 'El email ya está en uso'};
          } else if (e.code == 'invalid-email') {
            return {'result': 'error', 'detail': 'Email inválido'};
          } else {
            return {'result': 'error', 'detail': 'Error inesperado'};
          }
        } catch (_) {
          return {'result': 'error', 'detail': 'Error inesperado'};
        }
      }
      await _userDao.updateUser(
          userId: userId,
          phone: phone,
          email: email,
          gender: gender,
          birthdate: birthdate,
          profilePictureDownloadUrl: profilePictureDownloadUrl
      );
      return {'result': 'ok'};
    } catch (_) {
      return {'result': 'error', 'detail': 'Hubo un error al actualizar el usuario'};
    }
  }

  Future<Map<String, String>> changeFavouriteInVoluntariado({
    required String voluntariadoId,
    required bool postularse,
    required userId,
  }) async {
    try {
      await _userDao.changeFavouriteInVoluntariado(
          voluntariadoId: voluntariadoId,
          userId: userId,
          postularse: postularse
      );
      return {'result': 'ok'};
    } catch (_) {
      return {'result': 'error', 'detail': 'Hubo un error al marcar el voluntariado como favorito'};
    }

  }

  Future<void> changePostulacionToVoluntariado({
    required String voluntariadoId,
    required String userId,
    required bool postularse,
  }) async {
    await _userDao.changePostulacionToVoluntariado(
      voluntariadoId: voluntariadoId,
      userId: userId,
      changeTo: postularse
    );
  }
}