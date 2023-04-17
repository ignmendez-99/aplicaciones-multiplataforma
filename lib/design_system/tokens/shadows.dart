import 'package:flutter/material.dart';

class AppShadows {

  // TODO falta poner estas shadows a todo el mundo, mirar figma de todos los componentes

  static const BoxShadow hola = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.15),
    offset: Offset(0, 1),
    blurRadius: 3,
    spreadRadius: 1,
  );

  static const BoxShadow hola2 = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.3),
    offset: Offset(0, 1),
    blurRadius: 2,
    spreadRadius: 0,
  );

  static const BoxShadow chau = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.15),
    offset: Offset(0, 2),
    blurRadius: 6,
    spreadRadius: 2,
  );

  static const BoxShadow chau2 = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.3),
    offset: Offset(0, 1),
    blurRadius: 2,
    spreadRadius: 0,
  );

  static const BoxShadow ultimo = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.3),
    offset: Offset(0, 4),
    blurRadius: 4,
    spreadRadius: 0,
  );

  static const BoxShadow ultimo2 = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.15),
    offset: Offset(0, 8),
    blurRadius: 12,
    spreadRadius: 6,
  );

}