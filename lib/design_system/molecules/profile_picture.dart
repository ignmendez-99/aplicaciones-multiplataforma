import 'dart:io';

import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final double width;
  final double height;
  final File? file;
  final String? profilePictureDownloadUrl;

  const ProfilePicture({
    super.key,
    required this.width,
    required this.height,
    this.file,
    this.profilePictureDownloadUrl
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: file != null ?
          CircleAvatar(
            radius: 42,
            backgroundImage: FileImage(file!),
          )
          :
          CircleAvatar(
            radius: 42,
            backgroundImage: NetworkImage(profilePictureDownloadUrl!),
          )
    );
  }
}

class ProfilePictureBig extends ProfilePicture {
  const ProfilePictureBig({
    super.key,
    File? file,
    String? profilePictureDownloadUrl,
  }) : super(
    width: 110,
    height: 110,
    file: file,
    profilePictureDownloadUrl: profilePictureDownloadUrl
  );
}

class ProfilePictureSmall extends ProfilePicture {
  const ProfilePictureSmall({
    super.key,
    File? file,
    String? profilePictureDownloadUrl,
  }) : super(
    width: 84,
    height: 84,
    file: file,
    profilePictureDownloadUrl: profilePictureDownloadUrl
  );
}

class ProfilePictureEmpty extends StatelessWidget {
  const ProfilePictureEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(90),
        child: Image.asset(
          "assets/images/account_circle_two_tones.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}