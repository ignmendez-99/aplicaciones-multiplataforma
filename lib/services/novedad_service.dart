import 'package:aplicaciones_multiplataforma/persistence/novedad_dao.dart';
import 'package:flutter/cupertino.dart';

import '../models/novedad.dart';

class NovedadService with ChangeNotifier{

  static NovedadService? _instance;

  NovedadService._(); // Private constructor

  factory NovedadService() {
    if (_instance == null) {
      _instance = NovedadService._();
    }
    return _instance!;
  }

  final NovedadDao _novedadDao = NovedadDao();

  Future<Novedad?> getNovedadById(String id) async {
    return await _novedadDao.getNovedadById(id);
  }

  Future<List<Novedad>> getAllNovedades() async {
    return await _novedadDao.getAllNovedades();
  }
}