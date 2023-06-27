import 'package:flutter/material.dart';

class AppColors {
  static const Color neutralWhite = Color.fromARGB(255, 255, 255, 255);
  static const Color neutralBlack = Color.fromARGB(255, 25,  25,  25);

  static const Color neutralGrey10 = Color.fromARGB(255, 250, 250, 250);
  static const Color neutralGrey25 = Color.fromARGB(255, 224, 224, 224);
  static const Color neutralGrey50 = Color.fromARGB(255, 158, 158, 158);
  static const Color neutralGrey75 = Color.fromARGB(255, 102, 102, 102);

  static const Color primary100 = Color.fromARGB(255, 20,  144, 63);
  static const Color primary10  = Color.fromARGB(255, 231, 244, 236);
  static const Color primary5   = Color.fromARGB(255, 243, 249, 245);

  static const Color secondaryBlue10  = Color.fromARGB(255, 234, 245, 253);
  static const Color secondaryBlue25  = Color.fromARGB(255, 202, 229, 251);
  static const Color secondaryBlue50  = Color.fromARGB(255, 144, 202, 249);
  static const Color secondaryBlue80  = Color.fromARGB(255, 108, 182, 243);
  static const Color secondaryBlue90  = Color.fromARGB(255, 74,  169, 245);
  static const Color secondaryBlue100 = Color.fromARGB(255, 44,  152, 240);
  static const Color secondaryBlue200 = Color.fromARGB(255, 13,  71,  161);

  static const Color error = Color.fromARGB(255, 179, 38, 30);

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;
    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}