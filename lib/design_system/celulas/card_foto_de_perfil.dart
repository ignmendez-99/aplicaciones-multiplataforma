import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_corto.dart';
import 'package:flutter/material.dart';

import '../tokens/colors.dart';
import '../tokens/typography.dart';

class CardFotoDePerfil extends StatelessWidget {
  const CardFotoDePerfil({Key? key}) : super(key: key);

  static const List<String> generos = ['Hombre', 'Mujer', 'No binario'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryBlue25,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 14, 0, 14),
            child: Text(
              'Foto de perfil',
              style: MyTheme.subtitle01(),
            ),
          ),
          const Spacer(),
          ShortButtonChico(
            onPressed: (){},
            content: Container(
              margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Text(
                'Subir foto',
                style: MyTheme.button(color: AppColors.neutralWhite),
              ),
            ),
          )
        ],
      ),
    );
  }
}
