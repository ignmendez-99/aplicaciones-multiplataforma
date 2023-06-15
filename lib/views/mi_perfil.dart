import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_corto.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/colors.dart';
import 'package:flutter/material.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/typography.dart';

import '../design_system/atoms/icons.dart';
import '../design_system/molecules/profile_picture.dart';
import '../services/auth/auth_service.dart';

class MiPerfil extends StatelessWidget {
  MiPerfil({Key? key}) : super(key: key);

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          const Spacer(),
          // const ProfilePictureBig(),
          ProfilePictureEmpty(),
          const SizedBox(height: 16),
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
          ),
          const Spacer(),
          Container(
            // margin: const EdgeInsets.only(bottom: 80),
            child: ShortButtonDefault(
              onPressed: () { },
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyIcons.addNeutralWhite,
                  const SizedBox(width: 8,),
                  Text(
                    'Completar',
                    style: MyTheme.button(color: AppColors.neutralWhite),
                  )
                ],
              ),
            ),
          ),
          // ButtonCTAFilled(
          //   onPressed: () async {
          //     await _authService.signOut();
          //     // Navigator.of(context).popUntil((route) => false);
          //     Navigator.of(context).pushReplacementNamed('/start');
          //   },
          //   buttonText: 'Cerrar sesión'
          // ),
        ],
      ),
    );
  }
}
