import 'package:aplicaciones_multiplataforma/views/register.dart';
import 'package:aplicaciones_multiplataforma/views/start.dart';
import 'package:aplicaciones_multiplataforma/views/welcome.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  group('should test goldens', () {
    testGoldens('matches start window', (tester) async {
      final builder = DeviceBuilder()
        ..addScenario(
          widget: const Start(),
        );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'start');
    });

    testGoldens('matches welcome window', (tester) async {
      final builder = DeviceBuilder()
        ..addScenario(
          widget: const Welcome(),
        );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'welcome');
    });
  });
}
