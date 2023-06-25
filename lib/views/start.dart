import 'package:aplicaciones_multiplataforma/design_system/atoms/logo_cuadrado.dart';
import 'package:aplicaciones_multiplataforma/design_system/atoms/status_bar.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/typography.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../design_system/tokens/colors.dart';

class Start extends StatelessWidget {
  const Start({super.key});

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
                const SizedBox(height: 32),
                Text(
                    AppLocalizations.of(context)!.startMessage,
                  style: MyTheme.subtitle01(),
                  textAlign: TextAlign.center
                ),
                const Spacer(),
                FutureBuilder(
                  future: _requestTrackingAuthorization(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if(snapshot.hasData && snapshot.data != null) {
                      final bool hasPermissions = snapshot.data!;
                      if(!hasPermissions) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 32),
                          child: Center(
                            child: Text(
                              'Se necesita permitir el acceso al a recopilación de datos',
                              style: MyTheme.subtitle01(color: AppColors.error),
                            ),
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            ButtonCTAFilled(
                              onPressed: () {
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
                                  context.goNamed('register');
                                },
                                buttonText: AppLocalizations.of(context)!.register,
                                disabled: false,
                              ),
                            ),
                          ],
                        );
                      }
                    } else {
                      return Container();
                    }
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _requestTrackingAuthorization() async {
    final status = await AppTrackingTransparency.requestTrackingAuthorization();
    if(status == TrackingStatus.notSupported) {
      return true;
    }
    return status == TrackingStatus.authorized;
  }
}