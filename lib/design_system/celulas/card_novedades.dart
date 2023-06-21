import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../tokens/colors.dart';
import '../tokens/typography.dart';

class CardNovedades extends StatelessWidget {
  const CardNovedades({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: SizedBox(
        height: 156,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 156,
              width: 118,
              child: FittedBox(
                clipBehavior: Clip.hardEdge,
                fit: BoxFit.fitHeight,
                child: Image.asset(
                  "assets/images/donacion-sangre-chica-joven-camiseta-roja-grabada-mano-parche-corazon-rojo-despues-dar-sangre-sobre-fondo-gris_89386-1287.jpeg",
                ),
              ),
            ),
            Container(
              width: 194,
              padding: const EdgeInsets.fromLTRB(8, 6, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'REPORTE 2820',
                    style: MyTheme.overline(color: AppColors.neutralGrey75),
                  ),
                  Text(
                    'Ser donante voluntario',
                    style: MyTheme.subtitle01(),
                  ),
                  Text(
                    'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
                    style: MyTheme.body02(color: AppColors.neutralGrey75),
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonCTANotFilled(
                        onPressed: (){},
                        buttonText: AppLocalizations.of(context)!.readMore,
                        disabled: false,
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
