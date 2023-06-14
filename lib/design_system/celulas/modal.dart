import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:flutter/material.dart';

import '../tokens/colors.dart';
import '../tokens/shadows.dart';
import '../tokens/typography.dart';

class Modal extends StatelessWidget {
  const Modal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: AppShadows.sombra3,
        ),
        width: 280,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Te estás por postular a',
              style: MyTheme.subtitle01(),
            ),
            Text(
              'Un Techo para mi País',
              style: MyTheme.headline02(),
            ),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonCTANotFilled(
                  buttonText: 'Cancelar',
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 8,),
                ButtonCTANotFilled(
                  buttonText: 'Confirmar',
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
