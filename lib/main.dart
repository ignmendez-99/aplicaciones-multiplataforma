import 'package:aplicaciones_multiplataforma/views/login.dart';
import 'package:aplicaciones_multiplataforma/views/card_seleccionada.dart';
import 'package:aplicaciones_multiplataforma/views/dashboard.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/colors.dart';
import 'package:aplicaciones_multiplataforma/views/register.dart';
import 'package:aplicaciones_multiplataforma/views/start.dart';
import 'package:aplicaciones_multiplataforma/views/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

// https://www.figma.com/file/iCyHRyGBGaKOqS1ioWbJeI/Ser-manos-%7C-Design-System?node-id=231%3A1648&t=OKsdvc6OSI4nOwpw-1

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
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
      ),
      home: const Dashboard(),
      initialRoute: '/start',
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