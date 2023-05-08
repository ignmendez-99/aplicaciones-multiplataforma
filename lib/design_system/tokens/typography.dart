import 'package:aplicaciones_multiplataforma/design_system/tokens/colors.dart';
import 'package:flutter/material.dart';

class MyTheme {

  static TextStyle headline01({color = AppColors.neutralBlack}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,  // REGULAR
      fontSize: 24.0,
      height: 1,
      letterSpacing: 0.18,
      color: color
    );
  }

  static TextStyle headline02({color = AppColors.neutralBlack}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,  // MEDIUM
      fontSize: 20.0,
      height: 1.20,
      letterSpacing: 0.15,
      color: color
    );
  }

  static TextStyle subtitle01({color = AppColors.neutralBlack}) {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,  // REGULAR
        fontSize: 16.0,
        height: 1.5,
        letterSpacing: 0.15,
        color: color
    );
  }

  static TextStyle body01({color = AppColors.neutralBlack}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,  // REGULAR
      fontSize: 14.0,
      letterSpacing: 0.25,
      height: (20/14),
      color: color
    );
  }

  static TextStyle body02({color = AppColors.neutralBlack}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,  // REGULAR
      fontSize: 12.0,
      height: (16/14),
      letterSpacing: 0.4,
      color: color
    );
  }

  static TextStyle button({color = AppColors.neutralBlack}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,  // MEDIUM
      fontSize: 14.0,
      height: (20/14),
      letterSpacing: 0.1,
      color: color
    );
  }

  static TextStyle caption({color = AppColors.neutralBlack}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,  // REGULAR
      fontSize: 12.0,
      letterSpacing: 0.4,
      height: (16/14),
      color: color
    );
  }

  static TextStyle overline({color = AppColors.neutralBlack}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,  // MEDIUM
      fontSize: 10.0,
      height: 1.6,
      letterSpacing: 1.5,
      color: color
    );
  }

}