import 'package:aplicaciones_multiplataforma/design_system/atoms/logo_cuadrado.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/typography.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 177),
            const LogoCuadrado(),
            const SizedBox(height: 32),
            Text(
              '“El esfuerzo desinteresado para llevar alegría a los demás será el comienzo de una vida más feliz para nosotros”',
              style: MyTheme.subtitle01(),
              textAlign: TextAlign.center
            ),
            const SizedBox(height: 181),
            ButtonCTAFilled(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/login');
              },
              buttonText: 'Iniciar Sesión',
            ),
            const SizedBox(height: 16),
            ButtonCTANotFilled(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/register');
              },
              buttonText: 'Registrarse'
            ),
          ],
        ),
      ),
    );
  }
}