import 'package:aplicaciones_multiplataforma/models/voluntariado.dart';
import 'package:aplicaciones_multiplataforma/persistence/voluntariado_dao.dart';
import 'package:aplicaciones_multiplataforma/services/analytics_service.dart';
import 'package:aplicaciones_multiplataforma/services/auth/auth_service.dart';
import 'package:aplicaciones_multiplataforma/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../models/user.dart';
import 'location_permission_service.dart';

class VoluntariadoService with ChangeNotifier {

  static VoluntariadoService? _instance;

  VoluntariadoService._(); // Private constructor

  factory VoluntariadoService() {
    if (_instance == null) {
      _instance = VoluntariadoService._();
    }
    return _instance!;
  }

  final VoluntariadoDao _voluntariadoDao = VoluntariadoDao(FirebaseFirestore.instance);
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();
  final AnalyticsService _analyticsService = AnalyticsService();
  final LocationPermissionService _locationPermissionService = LocationPermissionService();

  Future<List<Voluntariado>> getAllVoluntariados({required String filterBy}) async {
    final List<Voluntariado> voluntariados = await _voluntariadoDao.getAllVoluntariados(filterBy: filterBy);
    if(filterBy == '') {
      List<Voluntariado> voluntariadosSorted = await sortByLocation(voluntariados);
      return addFavourites(voluntariadosSorted);
    } else {
      return addFavourites(voluntariados);
    }
  }

  Future<Voluntariado?> getVoluntariadoById(String id) async {
    return await _voluntariadoDao.getVoluntariadoById(id);
  }

  Future<List<Voluntariado>> getVoluntariadosFilteredByName({required String? titleFilter}) async {
    String filterBy = 'created_date';
    if(await _locationPermissionService.hasLocationPermission()) {
      filterBy = '';
    } else {
      bool userEnabledPermission = await _locationPermissionService.requestLocationPermission();
      if(userEnabledPermission) {
        filterBy = '';
      }
    }

    if(titleFilter == null || titleFilter.trim().isEmpty) {
      return await getAllVoluntariados(filterBy: filterBy);
    } else {
      await _analyticsService.sendEvent(type: 'search', data: titleFilter);
      final List<Voluntariado> voluntariados = await _voluntariadoDao.getVoluntariadosFilteredByName(
          titleFilter: titleFilter,
          filterBy: filterBy
      );
      List<Voluntariado> voluntariadosSorted = await sortByLocation(voluntariados);
      return addFavourites(voluntariadosSorted);
    }
  }

  Future<List<Voluntariado>> addFavourites(List<Voluntariado> voluntariados) async {
    final List<Voluntariado> voluntariadosLocal = voluntariados;
    final String loggedUserId = _authService.currentUser!.id;
    final SerManosUser loggedUser = await _userService.getUserById(loggedUserId);
    final List<String> favourites = loggedUser.favourites;
    for(Voluntariado v in voluntariadosLocal) {
      if(favourites.contains(v.id)) {
        v.favorito = true;
      }
    }
    return voluntariadosLocal;
  }

  Future<List<Voluntariado>> sortByLocation(List<Voluntariado> voluntariados) async {
    final List<Voluntariado> voluntariadosLocal = voluntariados;
    Position position = await Geolocator.getCurrentPosition();
    voluntariadosLocal.sort((a, b) {
      double distanceA = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        a.ubicacion.latitude,
        a.ubicacion.longitude,
      );
      double distanceB = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        b.ubicacion.latitude,
        b.ubicacion.longitude,
      );
      return distanceA.compareTo(distanceB);
    });
    return voluntariadosLocal;
  }

  Future<void> postularseAVoluntariado({
    required String voluntariadoId,
    required bool postularse,
    required int currentVacantes
  }) async {
    await _userService.changePostulacionToVoluntariado(
        voluntariadoId: voluntariadoId,
        userId: _authService.currentUser!.id,
        postularse: postularse
    );
    await _voluntariadoDao.changePostulacionToVoluntariado(
      voluntariadoId: voluntariadoId,
      postularse: postularse,
      currentVacantes: currentVacantes,
      userId: _authService.currentUser!.id,
    );
  }
}