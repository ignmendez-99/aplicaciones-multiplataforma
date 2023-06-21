import 'package:aplicaciones_multiplataforma/design_system/atoms/logo_cuadrado.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/typography.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                  AppLocalizations.of(context)!.startMessage,
                style: MyTheme.subtitle01(),
                textAlign: TextAlign.center
              ),
              // const SizedBox(height: 181),
              const Spacer(),
              ButtonCTAFilled(
                onPressed: () {
                  // Navigator.of(context).pushReplacementNamed('/login');
                  context.goNamed('login');
                },
                buttonText: AppLocalizations.of(context)!.login,
                disabled: false,
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.only(bottom: 32),
                child: ButtonCTANotFilled(
                  onPressed: () {
                    // Navigator.of(context).pushReplacementNamed('/register');
                    context.goNamed('register');
                  },
                  buttonText: AppLocalizations.of(context)!.register,
                  disabled: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}