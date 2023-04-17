import 'package:aplicaciones_multiplataforma/design_system/tokens/colors.dart';
import 'package:flutter/material.dart';

class MyTheme {

  // TODO revisar propiedades extra, como line spacing, ya que estas propiedades aparecen en el Figma

  static TextStyle headline01({color = AppColors.neutralBlack}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,  // REGULAR
      fontSize: 24.0,
      color: color
    );
  }

  static TextStyle headline02({color = AppColors.neutralBlack}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,  // MEDIUM
      fontSize: 20.0,
      color: color
    );
  }

  static TextStyle subtitle01({color = AppColors.neutralBlack}) {
    return TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,  // REGULAR
        fontSize: 16.0,
        color: color
    );
  }

  static TextStyle body01({color = AppColors.neutralBlack}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,  // REGULAR
      fontSize: 14.0,
      color: color
    );
  }

  static TextStyle body02({color = AppColors.neutralBlack}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,  // REGULAR
      fontSize: 12.0,
      color: color
    );
  }

  static TextStyle button({color = AppColors.neutralBlack}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,  // MEDIUM
      fontSize: 14.0,
      color: color
    );
  }

  static TextStyle caption({color = AppColors.neutralBlack}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,  // REGULAR
      fontSize: 12.0,
      color: color
    );
  }

  static TextStyle overline({color = AppColors.neutralBlack}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,  // MEDIUM
      fontSize: 10.0,
      color: color
    );
  }

}