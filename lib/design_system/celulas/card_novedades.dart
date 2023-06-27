import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/models/novedad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../tokens/colors.dart';
import '../tokens/typography.dart';

class CardNovedades extends StatelessWidget {
  final Novedad novedad;

  const CardNovedades({
    super.key,
    required this.novedad
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          SizedBox(
            height: 156,
            width: 118,
            child: FittedBox(
              clipBehavior: Clip.hardEdge,
              fit: BoxFit.fitHeight,
              child: Image.network(novedad.pictureDownloadUrl),
            ),
          ),
          Container(
            width: 194,
            padding: const EdgeInsets.fromLTRB(8, 6, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  novedad.titulo1,
                  style: MyTheme.overline(color: AppColors.neutralGrey75),
                ),
                Text(
                  novedad.titulo2,
                  style: MyTheme.subtitle01(),
                ),
                Text(
                  novedad.subtitulo,
                  style: MyTheme.body02(color: AppColors.neutralGrey75),
                ),
                const SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonCTANotFilled(
                      onPressed: (){
                        context.goNamed('novedad', pathParameters: {'novedadId': novedad.id});
                      },
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
    );
  }
}
