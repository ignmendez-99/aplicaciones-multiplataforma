import 'package:aplicaciones_multiplataforma/models/voluntariado.dart';
import 'package:aplicaciones_multiplataforma/persistence/voluntariado_dao.dart';
import 'package:aplicaciones_multiplataforma/services/auth/auth_service.dart';
import 'package:aplicaciones_multiplataforma/services/user_service.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class VoluntariadoService with ChangeNotifier {

  static VoluntariadoService? _instance;

  VoluntariadoService._(); // Private constructor

  factory VoluntariadoService() {
    if (_instance == null) {
      _instance = VoluntariadoService._();
    }
    return _instance!;
  }

  final VoluntariadoDao _voluntariadoDao = VoluntariadoDao();
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();

  Future<List<Voluntariado>> getAllVoluntariados() async {
    final List<Voluntariado> voluntariados = await _voluntariadoDao.getAllVoluntariados();
    final String loggedUserId = _authService.currentUser!.id;
    final User loggedUser = await _userService.getUserById(loggedUserId);
    final List<String> favourites = loggedUser.favourites;
    for(Voluntariado v in voluntariados) {
      if(favourites.contains(v.id)) {
        v.favorito = true;
      }
    }
    return voluntariados;
  }

  Future<Voluntariado?> getVoluntariadoById(String id) async {
    return await _voluntariadoDao.getVoluntariadoById(id);
  }

  Future<List<Voluntariado>> getVoluntariadosFilteredByName({required String titleFilter}) async {
    return await _voluntariadoDao.getVoluntariadosFilteredByName(titleFilter: titleFilter);
  }
}