import 'package:aplicaciones_multiplataforma/design_system/celulas/card_informacion.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_corto.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/colors.dart';
import 'package:flutter/material.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/typography.dart';
import 'package:go_router/go_router.dart';

import '../design_system/atoms/icons.dart';
import '../design_system/celulas/modal.dart';
import '../design_system/molecules/profile_picture.dart';
import '../models/user.dart';
import '../services/auth/auth_service.dart';
import '../utils/date_utils.dart';

class MiPerfil extends StatefulWidget {
  const MiPerfil({
    super.key,
    required this.loggedUser
  });

  final Future<User> loggedUser;

  @override
  State<MiPerfil> createState() => _MiPerfilState();
}

class _MiPerfilState extends State<MiPerfil> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.loggedUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if(snapshot.hasData && snapshot.data != null) {
          final User user = snapshot.data!;
          if(user.userUpdated) {
            return profileWithUserData(user);
          } else {
            return profileWithNoData(user);
          }
        } else {
          // CASO IMPOSIBLE
          return Container();
        }
      },
    );
  }

  Widget profileWithUserData(User user) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.neutralWhite,
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 42),
        child: Column(
          children: [
            user.profilePictureDownloadUrl != null ?
                ProfilePictureBig(profilePictureDownloadUrl: user.profilePictureDownloadUrl,)
                :
                const ProfilePictureEmpty(),
            const SizedBox(height: 16,),
            Text(
              'VOLUNTARIO',
              style: MyTheme.overline(color: AppColors.neutralGrey75),
            ),
            const SizedBox(height: 2,),
            Text(
              '${user.firstName} ${user.lastName}',
              style: MyTheme.subtitle01(),
            ),
            const SizedBox(height: 2,),
            Text(
              user.email,
              style: MyTheme.body01(color: AppColors.secondaryBlue200),
            ),
            const SizedBox(height: 32,),
            CardInformacion(
              titulo: 'Información personal',
              label1: 'FECHA DE NACIMIENTO',
              content1: SerManosDateUtils.dateFormatter.format(user.birthdate!),
              label2: 'GÉNERO',
              content2: user.gender!,
            ),
            const SizedBox(height: 32,),
            CardInformacion(
              titulo: 'Datos de contacto',
              label1: 'TELÉFONO',
              content1: user.phone!,
              label2: 'E-MAIL',
              content2: user.email,
            ),
            const SizedBox(height: 32,),
            ButtonCTAFilled(
              onPressed: () {
                context.goNamed('editProfile');
              },
              buttonText: 'Editar perfil',
              disabled: false
            ),
            const SizedBox(height: 8,),
            ButtonCTANotFilled(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => Modal(
                  modalBody: Text(
                    '¿Estás seguro que quieres cerrar sesión?',
                    style: MyTheme.subtitle01(),
                  ),
                  buttonOneText: 'Cancelar',
                  buttonTwoText: 'Cerrar sesión',
                  onPressedButtonOne: () {
                    Navigator.pop(context);
                  },
                  onPressedButtonTwo: () async {
                    await _authService.signOut();
                    context.goNamed('start');
                  },
                ),
              ),
              buttonText: 'Cerrar sesión',
              disabled: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget profileWithNoData(User user) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.neutralWhite,
        padding: const EdgeInsets.fromLTRB(16, 147.5, 16, 80),
        child: Column(
          children: [
            const ProfilePictureEmpty(),
            const SizedBox(height: 16),
            Text(
              'VOLUNTARIO',
              style: MyTheme.overline(color: AppColors.neutralGrey75),
            ),
            const SizedBox(height: 8),
            Text(
              '${user.firstName} ${user.lastName}',
              style: MyTheme.subtitle01(),
            ),
            const SizedBox(height: 8),
            Text(
              '¡Completá tu perfil para tener \nacceso a mejores oportunidades!',
              textAlign: TextAlign.center,
              style: MyTheme.body01(color: AppColors.neutralGrey75),
            ),
            const SizedBox(height: 147.5,),
            ShortButtonDefault(
              onPressed: () {
                context.goNamed('editProfile');
              },
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
          ],
        ),
      ),
    );
  }
}
