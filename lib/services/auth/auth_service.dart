import 'package:aplicaciones_multiplataforma/services/analytics_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:aplicaciones_multiplataforma/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, FirebaseAuthException, User;
import 'package:flutter/material.dart';

import 'auth_user.dart';

class AuthService with ChangeNotifier{

  static AuthService? _instance;

  AuthService._(); // Private constructor

  factory AuthService() {
    if (_instance == null) {
      _instance = AuthService._();
    }
    return _instance!;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final UserService _userService = UserService();
  final AnalyticsService _analyticsService = AnalyticsService();

  AuthUser? get currentUser {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return AuthUser.from(user);
    } else {
      return null;
    }
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<Map<String, String>> logIn({required String email, required String password, BuildContext? context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      await _analyticsService.sendEvent(type: 'login');
      return {'result': 'ok'};
    } on FirebaseAuthException {
      return {'result': 'error', 'detail': AppLocalizations.of(context!)!.invalidCredentials};
    } catch (_) {
      return {'result': 'error', 'detail': AppLocalizations.of(context!)!.unexpectedErrror};
    }
  }

  Future<Map<String, String>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    BuildContext? context
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await _userService.createUser(
        email: email,
        emailVerified: false,
        firstName: firstName,
        lastName: lastName,
        userId: currentUser!.id,
      );
      await _analyticsService.sendEvent(type: 'sign_up');
      return {'result': 'ok'};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return {'result': 'error', 'detail': AppLocalizations.of(context!)!.weakPassword};
      } else if (e.code == 'email-already-in-use') {
        return {'result': 'error', 'detail': AppLocalizations.of(context!)!.emailAlreadyInUse};
      } else if (e.code == 'invalid-email') {
        return {'result': 'error', 'detail': AppLocalizations.of(context!)!.invalidEmail};
      } else {
        return {'result': 'error', 'detail': AppLocalizations.of(context!)!.unexpectedErrror};
      }
    } catch (_) {
      return {'result': 'error', 'detail': AppLocalizations.of(context!)!.unexpectedErrror};
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

}