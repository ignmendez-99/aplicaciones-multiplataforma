import 'package:aplicaciones_multiplataforma/design_system/molecules/vacantes.dart';
import 'package:aplicaciones_multiplataforma/models/voluntariado.dart';
import 'package:aplicaciones_multiplataforma/services/maps_service.dart';
import 'package:flutter/material.dart';

import '../atoms/icons.dart';
import '../tokens/colors.dart';
import '../tokens/shadows.dart';
import '../tokens/typography.dart';

class CardVoluntariado extends StatelessWidget {

  final Voluntariado voluntariado;
  final MapService _mapService = MapService();

  CardVoluntariado({
    Key? key,
    required this.voluntariado
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: AppShadows.sombra2,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => {
                Navigator.of(context).pushNamed('/card-seleccionada/')
              },
              child: SizedBox(
                height: 138,
                width: double.infinity,
                child: FittedBox(
                  clipBehavior: Clip.hardEdge,
                  fit: BoxFit.fitWidth,
                  child: Image.asset(
                    "assets/images/1109 techo 500.jpeg",
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 18, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        voluntariado.tipoDeVoluntariado,
                        style: MyTheme.overline(color: AppColors.neutralGrey75),
                      ),
                      Text(
                        voluntariado.titulo,
                        style: MyTheme.subtitle01(),
                      ),
                      Vacantes(vacantes: voluntariado.vacantes,)
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      MyIcons.favoriteOutlineActivated,
                      const SizedBox(width: 16,),
                      GestureDetector(
                        onTap: () => _mapService.openGoogleMaps(voluntariado.ubicacion.latitude, voluntariado.ubicacion.longitude),
                        child: MyIcons.locationOnActivated
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
