import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final double width;
  final double height;

  const ProfilePicture({
    super.key,
    required this.width,
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(90),
        child: Image.asset(
          "assets/images/image.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ProfilePictureBig extends ProfilePicture {
  const ProfilePictureBig({
    super.key,
  }) : super(
    width: 110,
    height: 110,
  );
}

class ProfilePictureSmall extends ProfilePicture {
  const ProfilePictureSmall({
    super.key,
  }) : super(
    width: 84,
    height: 84,
  );
}