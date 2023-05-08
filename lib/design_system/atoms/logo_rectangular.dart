import 'package:flutter/material.dart';

class LogoRectangular extends StatelessWidget {

  static const double logoWidth = 147;
  static const double logoHeight = 25;

  const LogoRectangular({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/SER MANOS-02.png",
      width: logoWidth,
      height: logoHeight,
      fit: BoxFit.fill,
    );
  }
}