import 'package:aplicaciones_multiplataforma/ser_manos_router.dart';
import 'package:aplicaciones_multiplataforma/services/auth/auth_service.dart';
import 'package:aplicaciones_multiplataforma/services/voluntariado_service.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthService()),
      ChangeNotifierProvider(create: (_) => VoluntariadoService()),
    ],
    child: const MyApp(),
  ));
}

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

    return MaterialApp.router(
      routerConfig: SerManosRouter.router,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
      ),
    );
  }
}
