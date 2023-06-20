import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' show FirebaseStorage, Reference;

class PictureDao {

  final Reference _storageRef = FirebaseStorage.instance.ref();

  Future<String> uploadPicture({required String fileName, required File imageFile}) async {
    final pictureRef = _storageRef.child(fileName);
    await pictureRef.putFile(imageFile);
    return await _storageRef.child(fileName).getDownloadURL();
    // await mountainsRef.putFile(
    //   file,
    //   SettableMetadata(
    //     contentType: "image/jpeg",
    // ));
  }
}