import 'package:aplicaciones_multiplataforma/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, FirebaseAuthException, User, UserCredential;
import 'package:flutter/material.dart';

import 'auth_exceptions.dart';
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

  Future<AuthUser?> logIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  Future<void> signUp({
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

}