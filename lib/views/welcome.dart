import 'package:aplicaciones_multiplataforma/design_system/atoms/logo_cuadrado.dart';
import 'package:aplicaciones_multiplataforma/design_system/atoms/status_bar.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/typography.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../design_system/tokens/colors.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return SerManosStatusBarWidget(
      statusBarColor: AppColors.neutralWhite,
      child: Scaffold(
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
                    AppLocalizations.of(context)!.welcome,
                    style: MyTheme.headline01()
                ),
                const SizedBox(height: 48),
                Text(
                  AppLocalizations.of(context)!.welcomeMessage,
                  style: MyTheme.subtitle01(),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(bottom: 92),
                  child: ButtonCTAFilled(
                    onPressed: () {
                      // Navigator.pushNamed(context, '/home');
                      context.goNamed('voluntariados');
                    },
                    buttonText: AppLocalizations.of(context)!.start,
                    disabled: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}