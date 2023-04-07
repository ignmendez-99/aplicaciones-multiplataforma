import 'package:aplicaciones_multiplataforma/card_seleccionada.dart';
import 'package:aplicaciones_multiplataforma/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// https://www.figma.com/file/iCyHRyGBGaKOqS1ioWbJeI/Ser-manos-%7C-Design-System?node-id=231%3A1648&t=OKsdvc6OSI4nOwpw-1

// TODO: revisar pantalla horizontal
// todo: revisar pantallas cuando se abre el teclado

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
      ),
      home: const Dashboard(),
      routes: {
        '/card-seleccionada/':(context) => const CardSeleccionada()
      },
    );
  }
}