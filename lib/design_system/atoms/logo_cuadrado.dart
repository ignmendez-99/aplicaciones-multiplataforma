import 'package:flutter/material.dart';

class LogoCuadrado extends StatelessWidget {

  static const double logoWidth = 150;
  static const double logoHeight = 150;

  const LogoCuadrado({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/SER MANOS LOGO_Mesa de trabajo 1.png",
      width: logoWidth,
      height: logoHeight,
      fit: BoxFit.fill,
    );
  }
}