import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_corto.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/colors.dart';
import 'package:flutter/material.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/typography.dart';

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
                children: [
                  Text(
                    'VOLUNTARIO',
                    style: MyTheme.overline(color: AppColors.neutralGrey75),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Juan Cruz',
                    style: MyTheme.subtitle01(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '¡Completá tu perfil para tener \nacceso a mejores oportunidades!',
                    textAlign: TextAlign.center,
                    style: MyTheme.body01(color: AppColors.neutralGrey75),
                  )
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          margin: const EdgeInsets.only(bottom: 80),
          child: ShortButtonActivated(
            onPressed: () { },
            buttonText: 'Completar',
          ),
        )
      ],
    );
  }
}
