import 'package:aplicaciones_multiplataforma/design_system/atoms/logo_cuadrado.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/typography.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

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
              const SizedBox(height: 30),
              Text(
                  '¡Bienvenido!',
                  style: MyTheme.headline01()
              ),
              const SizedBox(height: 48),
              Text(
                'Nunca subestimes tu habilidad para mejorar la vida de alguien.',
                style: MyTheme.subtitle01(),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 92),
                child: ButtonCTAFilled(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  buttonText: 'Comenzar',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}