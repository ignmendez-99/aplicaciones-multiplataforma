import 'package:flutter/material.dart';

class AppShadows {

  static const List<BoxShadow> sombra1 = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 1,
    ),
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    )
  ];

  static const List<BoxShadow> sombra2 = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      offset: Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 2,
    ),
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    )
  ];

  static const List<BoxShadow> sombra3 = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      offset: Offset(0, 4),
      blurRadius: 4,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      offset: Offset(0, 8),
      blurRadius: 12,
      spreadRadius: 6,
    )
  ];

}