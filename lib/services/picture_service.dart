import 'dart:io';

import 'package:aplicaciones_multiplataforma/persistence/picture_dao.dart';

class PictureService {

  static PictureService? _instance;

  PictureService._(); // Private constructor

  factory PictureService() {
    if (_instance == null) {
      _instance = PictureService._();
    }
    return _instance!;
  }

  final PictureDao _pictureDao = PictureDao();

  Future<String> savePicture({required String fileName, required File imageFile}) async {
    return await _pictureDao.uploadPicture(fileName: fileName, imageFile: imageFile);
  }

}