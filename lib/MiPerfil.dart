import 'package:aplicaciones_multiplataforma/buttons/short_button_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:aplicaciones_multiplataforma/constants/themes.dart';

class MiPerfil extends StatefulWidget {
  const MiPerfil({Key? key}) : super(key: key);

  @override
  State<MiPerfil> createState() => _MiPerfilState();
}

class _MiPerfilState extends State<MiPerfil> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Column(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: Image.asset(
                  "assets/images/face.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: const [
                  Text('VOLUNTARIO', style: MyTheme.overlineNeutralGrey75,),
                  SizedBox(height: 8),
                  Text('Juan Cruz', style: MyTheme.subtitle01,),
                  SizedBox(height: 8),
                  Text(
                    '¡Completá tu perfil para tener \nacceso a mejores oportunidades!',
                    textAlign: TextAlign.center,
                    style: MyTheme.body01NeutralGrey75,
                  )
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          margin: const EdgeInsets.only(bottom: 80),
          child: ShortButtonWithIcon(
            icon: Icons.add,
            buttonText: 'Completar',
            onPressed: () {
              print('boton apretado');
            },
          ),
        )
      ],
    );
  }
}
