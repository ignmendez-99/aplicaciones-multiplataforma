import 'package:aplicaciones_multiplataforma/design_system/celulas/card_informacion.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_corto.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/colors.dart';
import 'package:aplicaciones_multiplataforma/utils/gender_utils.dart';
import 'package:flutter/material.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/typography.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  final Future<SerManosUser> loggedUser;

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
          final SerManosUser user = snapshot.data!;
          if(user.userUpdated) {
            return profileWithUserData(user);
          } else {
            return profileWithNoData(user);
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget profileWithUserData(SerManosUser user) {
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
              AppLocalizations.of(context)!.volunteer.toUpperCase(),
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
              titulo: AppLocalizations.of(context)!.personalInformation,
              label1: AppLocalizations.of(context)!.dateOfBirth.toUpperCase(),
              content1: SerManosDateUtils.dateFormatter(context).format(user.birthdate!),
              label2: AppLocalizations.of(context)!.gender.toUpperCase(),
              content2: GenderUtils.getGenderTranslated(genderInSpanish: user.gender!, context: context),
            ),
            const SizedBox(height: 32,),
            CardInformacion(
              titulo: AppLocalizations.of(context)!.contactData,
              label1: AppLocalizations.of(context)!.phone,
              content1: user.phone!,
              label2: AppLocalizations.of(context)!.email.toUpperCase(),
              content2: user.email,
            ),
            const SizedBox(height: 32,),
            ButtonCTAFilled(
              onPressed: () {
                context.goNamed('editProfile');
              },
              buttonText: AppLocalizations.of(context)!.editProfile,
              disabled: false
            ),
            const SizedBox(height: 8,),
            ButtonCTANotFilled(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => Modal(
                  modalBody: Text(
                    AppLocalizations.of(context)!.logoutConfirmation,
                    style: MyTheme.subtitle01(),
                  ),
                  buttonOneText: AppLocalizations.of(context)!.cancel,
                  buttonTwoText: AppLocalizations.of(context)!.logout,
                  onPressedButtonOne: () {
                    Navigator.pop(context);
                  },
                  onPressedButtonTwo: () async {
                    await _authService.signOut();
                    context.goNamed('start');
                  },
                ),
              ),
              buttonText: AppLocalizations.of(context)!.logout,
              disabled: false,
              textColor: AppColors.error,
            ),
          ],
        ),
      ),
    );
  }

  Widget profileWithNoData(SerManosUser user) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.neutralWhite,
        padding: const EdgeInsets.fromLTRB(16, 147.5, 16, 80),
        child: Column(
          children: [
            const ProfilePictureEmpty(),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.volunteer.toUpperCase(),
              style: MyTheme.overline(color: AppColors.neutralGrey75),
            ),
            const SizedBox(height: 8),
            Text(
              '${user.firstName} ${user.lastName}',
              style: MyTheme.subtitle01(),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.completeProfileMessage,
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
                    AppLocalizations.of(context)!.complete,
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
