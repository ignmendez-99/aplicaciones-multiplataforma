import 'package:aplicaciones_multiplataforma/services/auth/auth_service.dart';
import 'package:aplicaciones_multiplataforma/views/login.dart';
import 'package:aplicaciones_multiplataforma/views/card_seleccionada.dart';
import 'package:aplicaciones_multiplataforma/views/dashboard.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/colors.dart';
import 'package:aplicaciones_multiplataforma/views/register.dart';
import 'package:aplicaciones_multiplataforma/views/start.dart';
import 'package:aplicaciones_multiplataforma/views/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'auth_orchestrator.dart';
import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // AuthService().authStateChanges.listen((User? user) {
  //   Navigator.of(navigatorKey.currentContext!).popUntil((route) => false);
  //   if (user == null) {
  //     print('User is signed out!');
  //     Navigator.of(navigatorKey.currentContext!).pushNamed('/start');
  //   } else {
  //     print('User is signed in!');
  //     Navigator.of(navigatorKey.currentContext!).pushNamed('/welcome');
  //   }
  // });

  runApp(const MyApp());
}

// GoRouter configuration
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => AuthOrchestrator(),
    ),
  ],
);

// TODO: revisar pantalla horizontal
// todo: revisar pantallas cuando se abre el teclado

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.secondaryBlue90,
        // statusBarColor: AppColors.neutralWhite,
        // statusBarColor: AppColors.neutralBlack,
      ),
    );

    return MaterialApp(
      // routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
      ),
      home: AuthOrchestrator(),
      routes: {
        '/card-seleccionada/':(context) => const CardSeleccionada(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/start': (context) => const Start(),
        '/welcome': (context) => const Welcome(),
        '/home': (context) => const Dashboard(),
      },
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();