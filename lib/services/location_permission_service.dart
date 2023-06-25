import 'package:geolocator/geolocator.dart';

class LocationPermissionService {

  static LocationPermissionService? _instance;

  LocationPermissionService._(); // Private constructor

  factory LocationPermissionService() {
    if (_instance == null) {
      _instance = LocationPermissionService._();
    }
    return _instance!;
  }

  Future<bool> hasLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

}