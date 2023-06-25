import 'package:aplicaciones_multiplataforma/models/voluntariado.dart';
import 'package:aplicaciones_multiplataforma/services/maps_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../atoms/icons.dart';
import '../tokens/colors.dart';
import '../tokens/shadows.dart';
import '../tokens/typography.dart';

class CardVoluntariadoActual extends StatelessWidget {

  final Voluntariado voluntariado;
  final MapService _mapService = MapService();

  CardVoluntariadoActual({
    super.key,
    required this.voluntariado,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary5,
          border: Border.all(
            color: AppColors.primary100,
            width: 2
          ),
          boxShadow: AppShadows.sombra2,
        ),
        child: Row(
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
              ],
            ),
            const Spacer(),
            GestureDetector(
                onTap: () => _mapService.openGoogleMaps(
                  voluntariado.ubicacion.latitude,
                  voluntariado.ubicacion.longitude,
                ),
                child: MyIcons.locationOnActivated
            ),
          ],
        ),
      )
    );
  }
}
