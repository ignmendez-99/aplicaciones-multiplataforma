import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {

  static AnalyticsService? _instance;

  AnalyticsService._(); // Private constructor

  factory AnalyticsService() {
    if (_instance == null) {
      _instance = AnalyticsService._();
    }
    return _instance!;
  }

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> sendEvent({required String type, String? data}) async {
    if(type == 'login') {
      await _analytics.logLogin(loginMethod: 'logIn');
    } else if(type == 'sign_up'){
      await _analytics.logSignUp(signUpMethod: 'hola');
    } else if(type == 'search') {
      await _analytics.logSearch(searchTerm: data!);
    }
  }

}