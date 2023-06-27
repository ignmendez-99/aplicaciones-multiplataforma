import 'package:aplicaciones_multiplataforma/persistence/voluntariado_dao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('user testing', () {
    final fireStoreInstance = FakeFirebaseFirestore();
    final voluntariadoDao = VoluntariadoDao(firestoreInstance: fireStoreInstance);
    test('Gets all voluntariados', () async {
      var timestamp = Timestamp.fromMicrosecondsSinceEpoch(10);
      await fireStoreInstance.collection('voluntariados').doc('1').set({
        'aceptados': [],
        'costo': 2000.0,
        'created_date': timestamp,
        'descripcion_corta':
            'El propósito principal de "Un techo para mi país" es reducir el déficit habitacional y mejorar las condiciones de vida de las personas que no tienen acceso a una vivienda adecuada.',
        'descripcion_larga':
            'Te necesitamos para construir las viviendas de las personas que necesitan un techo. Estas están prefabricadas en madera y deberás ayudar en carpintería, montaje, pintura y demás actividades de la construcción.',
        'direccion': 'Echeverría 3560, Capital Federal.',
        'disponibilidad': '* Todos los dias de 9:00 a 10:00',
        'picture_download_url': 'http://url_to_image.com',
        'postulados': [],
        'requisitos': 'Mayor de edad. Poder levantar cosas pesadas.',
        'tipo_de_voluntariado': 'ACCIÓN SOCIAL',
        'titulo': 'Un Techo para mi Pais',
        'ubicacion': const GeoPoint(37.7749, -122.4194),
        'vacantes': 10
      });
      var voluntariados = await voluntariadoDao.getAllVoluntariados(filterBy: '');
      expect(voluntariados[0].descripcionCorta,
          'El propósito principal de "Un techo para mi país" es reducir el déficit habitacional y mejorar las condiciones de vida de las personas que no tienen acceso a una vivienda adecuada.');
      expect(voluntariados[0].descripcionLarga,
          'Te necesitamos para construir las viviendas de las personas que necesitan un techo. Estas están prefabricadas en madera y deberás ayudar en carpintería, montaje, pintura y demás actividades de la construcción.');
      expect(voluntariados[0].direccion, 'Echeverría 3560, Capital Federal.');
      expect(voluntariados[0].disponibilidad,
          '* Todos los dias de 9:00 a 10:00');
      expect(voluntariados[0].requisitos,
          'Mayor de edad. Poder levantar cosas pesadas.');
      expect(voluntariados[0].tipoDeVoluntariado, 'ACCIÓN SOCIAL');
      expect(voluntariados[0].ubicacion, const GeoPoint(37.7749, -122.4194));
      expect(voluntariados[0].vacantes, 10);
    });

    test('Gets one voluntariados', () async {
      var timestamp = Timestamp.fromMicrosecondsSinceEpoch(10);
      await fireStoreInstance.collection('voluntariados').doc('1').set({
        'aceptados': [],
        'costo': 2000.0,
        'created_date': timestamp,
        'descripcion_corta':
            'El propósito principal de "Un techo para mi país" es reducir el déficit habitacional y mejorar las condiciones de vida de las personas que no tienen acceso a una vivienda adecuada.',
        'descripcion_larga':
            'Te necesitamos para construir las viviendas de las personas que necesitan un techo. Estas están prefabricadas en madera y deberás ayudar en carpintería, montaje, pintura y demás actividades de la construcción.',
        'direccion': 'Echeverría 3560, Capital Federal.',
        'disponibilidad': '* Todos los dias de 9:00 a 10:00',
        'picture_download_url': 'http://url_to_image.com',
        'postulados': [],
        'requisitos': 'Mayor de edad. Poder levantar cosas pesadas.',
        'tipo_de_voluntariado': 'ACCIÓN SOCIAL',
        'titulo': 'Un Techo para mi Pais',
        'ubicacion': const GeoPoint(37.7749, -122.4194),
        'vacantes': 10
      });
      var voluntariado = await voluntariadoDao.getVoluntariadoById('1');

      expect(voluntariado?.descripcionCorta,
          'El propósito principal de "Un techo para mi país" es reducir el déficit habitacional y mejorar las condiciones de vida de las personas que no tienen acceso a una vivienda adecuada.');
      expect(voluntariado?.descripcionLarga,
          'Te necesitamos para construir las viviendas de las personas que necesitan un techo. Estas están prefabricadas en madera y deberás ayudar en carpintería, montaje, pintura y demás actividades de la construcción.');
      expect(voluntariado?.direccion, 'Echeverría 3560, Capital Federal.');
      expect(voluntariado?.disponibilidad,
          '* Todos los dias de 9:00 a 10:00');
      expect(voluntariado?.requisitos,
          'Mayor de edad. Poder levantar cosas pesadas.');
      expect(voluntariado?.tipoDeVoluntariado, 'ACCIÓN SOCIAL');
      expect(voluntariado?.ubicacion, const GeoPoint(37.7749, -122.4194));
      expect(voluntariado?.vacantes, 10);
    });
  });
}
