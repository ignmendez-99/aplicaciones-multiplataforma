import 'package:flutter/material.dart';

import 'buttons/long_button.dart';
import 'design_system/tokens/colors.dart';
import 'design_system/tokens/typography.dart';

class CardSeleccionada extends StatefulWidget {
  const CardSeleccionada({Key? key}) : super(key: key);

  @override
  State<CardSeleccionada> createState() => _CardSeleccionadaState();
}

class _CardSeleccionadaState extends State<CardSeleccionada> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 243,
            width: double.infinity,
            child: Image.asset(
              "assets/images/accion_social.jpeg",
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 32, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Un Techo para mi País',
                  textAlign: TextAlign.left,
                  style: MyTheme.headline01(),
                ),
                const SizedBox(height: 24),
                Text(
                  'A dos horas al sur de Vicente López en la ciudad de Buenos Aires.',
                  style: MyTheme.body01(color: AppColors.neutralGrey75),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 56),
            child: LongButton(
              buttonText: 'Postularme',
              onPressed: () => _dialogBuilder(context)
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 182,
            width: 280,
            child: Column(
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
                const SizedBox(height: 16,),
                Text(
                  'Días sábados de 9.00 a 17.00 horas.',
                  style: MyTheme.body01(color: AppColors.neutralGrey75),
                ),
                Text(
                  'Caballito',
                  style: MyTheme.body01(color: AppColors.neutralGrey75),
                ),
                const SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancelar',
                        style: MyTheme.button(color: AppColors.primary),
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Confirmar',
                        style: MyTheme.button(color: AppColors.primary),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
