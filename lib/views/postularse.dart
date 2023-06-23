import 'package:aplicaciones_multiplataforma/design_system/celulas/card_voluntariado.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/floating_button.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/colors.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/typography.dart';
import 'package:aplicaciones_multiplataforma/models/voluntariado.dart';
import 'package:aplicaciones_multiplataforma/services/voluntariado_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../design_system/celulas/card_foto_de_perfil.dart';
import '../design_system/celulas/card_informacion.dart';
import '../design_system/celulas/card_input.dart';
import '../design_system/celulas/card_voluntariado_actual.dart';
import '../design_system/molecules/buscador.dart';


class Postularse extends StatefulWidget {
  const Postularse({Key? key}) : super(key: key);

  @override
  State<Postularse> createState() => _PostularseState();
}

class _PostularseState extends State<Postularse> {

  final TextEditingController myController = TextEditingController();
  final VoluntariadoService _voluntariadoService = VoluntariadoService();
  String? _buscadorText;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 24, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Buscador(
              controller: myController,
              onEnterPressed: () {
                setState(() {
                  _buscadorText = myController.text;
                });
              },
              onClearPressed: () {
                setState(() {
                  _buscadorText = '';
                });
              }
            ),
            const SizedBox(height: 32),
            Text(
              AppLocalizations.of(context)!.volunteering,
              style: MyTheme.headline01(),
            ),
            const SizedBox(height: 16),
            FutureBuilder(
              future: _voluntariadoService.getVoluntariadosFilteredByName(titleFilter: _buscadorText),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if(snapshot.hasData && snapshot.data!.isNotEmpty) {
                  List<Voluntariado> voluntariados = snapshot.data as List<Voluntariado>;
                  return Column(
                    children: voluntariados.map((v) => CardVoluntariado(voluntariado: v)).toList(),
                  );
                } else {
                  return noData();
                }
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget noData() {
    String noVoluntariados;
    if(_buscadorText == null) {
      // No busco y no encontro nada ==> no hay voluntariados
      noVoluntariados = AppLocalizations.of(context)!.noVolunteersMessage;
    } else {
      // Es vacio o con texto. De cualquier manera, significa que hizo una busqueda
      noVoluntariados = 'No hay voluntariados vigentes para tu búsqueda.';
    }
    return Container(
      color: AppColors.neutralWhite,
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
      child: Text(
        noVoluntariados,
        textAlign: TextAlign.center,
        style: MyTheme.subtitle01(),
      ),
    );
  }

}


