import 'package:aplicaciones_multiplataforma/services/auth/auth_service.dart';
import 'package:aplicaciones_multiplataforma/views/start.dart';
import 'package:aplicaciones_multiplataforma/views/welcome.dart';
import 'package:flutter/material.dart';

class AuthOrchestrator extends StatelessWidget {
  AuthOrchestrator({Key? key}) : super(key: key);

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
          case ConnectionState.active:
            if (snapshot.hasData) {
              final user = _authService.currentUser;
              if (user == null) {
                return const Start();
              } else {
                return const Welcome();
              }
            } else {
              return const Start();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
