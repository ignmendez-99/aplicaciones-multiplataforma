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

  AuthUser? get currentUser {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return AuthUser.from(user);
    } else {
      return null;
    }
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<Map<String, String>> logIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return {'result': 'ok'};
    } on FirebaseAuthException {
      return {'result': 'error', 'detail': 'Las credenciales proporcionadas no son correctas'};
    } catch (_) {
      return {'result': 'error', 'detail': 'Error inesperado'};
    }
  }

  Future<Map<String, String>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
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
      return {'result': 'ok'};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return {'result': 'error', 'detail': 'Contraseña débil'};
      } else if (e.code == 'email-already-in-use') {
        return {'result': 'error', 'detail': 'El email ya está en uso'};
      } else if (e.code == 'invalid-email') {
        return {'result': 'error', 'detail': 'Email inválido'};
      } else {
        return {'result': 'error', 'detail': 'Error inesperado'};
      }
    } catch (_) {
      return {'result': 'error', 'detail': 'Error inesperado'};
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

}