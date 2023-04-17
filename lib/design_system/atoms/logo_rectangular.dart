import 'package:flutter/material.dart';

class LogoRectangular extends StatelessWidget {

  // TODO: falta el logo cuadrado del figma, ponelo en otro archivo mejor

  static const double logoWidth = 147;
  static const double logoHeight = 25;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/logo.png",
      width: logoWidth,
      height: 25,
      fit: BoxFit.fill,
    );
  }
}