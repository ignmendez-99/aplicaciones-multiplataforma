import 'package:aplicaciones_multiplataforma/design_system/atoms/logo_cuadrado.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/typography.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Spacer(),
              const LogoCuadrado(),
              const SizedBox(height: 32),
              Text(
                '“El esfuerzo desinteresado para llevar alegría a los demás será el comienzo de una vida más feliz para nosotros”',
                style: MyTheme.subtitle01(),
                textAlign: TextAlign.center
              ),
              // const SizedBox(height: 181),
              const Spacer(),
              ButtonCTAFilled(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                buttonText: 'Iniciar Sesión',
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                child: ButtonCTANotFilled(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/register');
                  },
                  buttonText: 'Registrarse'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}