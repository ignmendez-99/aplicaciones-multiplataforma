import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Voluntariado with ChangeNotifier{
  final String id;
  final DateTime createdDate;
  final String descripcionCorta;
  final String descripcionLarga;
  final String direccion;
  final List<String> disponibilidad;
  final String requisitos;
  final String tipoDeVoluntariado;
  final String titulo;
  final GeoPoint ubicacion;
  final int vacantes;
  bool favorito;

  Voluntariado({
    required this.id,
    required this.createdDate,
    required this.descripcionCorta,
    required this.descripcionLarga,
    required this.direccion,
    required this.disponibilidad,
    required this.requisitos,
    required this.tipoDeVoluntariado,
    required this.titulo,
    required this.ubicacion,
    required this.vacantes,
    this.favorito = false,
  });

  static Voluntariado fromJson({
    required String id,
    required Map<String, dynamic> json,
  }) {
    return Voluntariado(
      id: id,
      createdDate: (json['created_date'] as Timestamp).toDate(),
      descripcionCorta: json['descripcion_corta'] as String,
      descripcionLarga: json['descripcion_larga'] as String,
      direccion: json['direccion'] as String,
      disponibilidad: List<String>.from(json['disponibilidad'] as List<dynamic>),
      requisitos: json['requisitos'] as String,
      tipoDeVoluntariado: json['tipo_de_voluntariado'] as String,
      titulo: json['titulo'] as String,
      ubicacion: json['ubicacion'] as GeoPoint,
      vacantes: json['vacantes'] as int,
    );
  }
}