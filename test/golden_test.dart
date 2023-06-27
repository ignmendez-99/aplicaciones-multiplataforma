import 'package:aplicaciones_multiplataforma/views/start.dart';
import 'package:aplicaciones_multiplataforma/views/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  group('should test goldens', () {
    testGoldens('matches start window', (tester) async {
      final builder = DeviceBuilder()
        ..addScenario(
          widget: const MaterialApp(
              home: Start(),
              locale: Locale('es'),
              supportedLocales: [Locale('en'),Locale('es')],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ]),
        );
      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'start');
    });

    testGoldens('matches welcome window', (tester) async {
      final builder = DeviceBuilder()
        ..addScenario(
          widget: const MaterialApp(
              home: Welcome(),
              locale: Locale('es'),
              supportedLocales: [Locale('en'),Locale('es')],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ]),
        );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'welcome');
    });
  });
}
