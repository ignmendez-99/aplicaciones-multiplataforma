import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/vacantes.dart';
import 'package:aplicaciones_multiplataforma/models/voluntariado.dart';
import 'package:aplicaciones_multiplataforma/services/auth/auth_service.dart';
import 'package:aplicaciones_multiplataforma/services/voluntariado_service.dart';
import 'package:aplicaciones_multiplataforma/utils/date_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

import '../design_system/atoms/status_bar.dart';
import '../design_system/celulas/card_ubicacion.dart';
import '../design_system/celulas/modal.dart';
import '../design_system/tokens/colors.dart';
import '../design_system/tokens/typography.dart';
import '../models/user.dart';
import '../utils/currency_utils.dart';

class CardSeleccionada extends StatefulWidget {

  final Future<Voluntariado?> voluntariado;
  final Future<SerManosUser?> loggedUser;

  const CardSeleccionada({
    super.key,
    required this.voluntariado,
    required this.loggedUser,
  });

  @override
  State<CardSeleccionada> createState() => _CardSeleccionadaState();
}

class _CardSeleccionadaState extends State<CardSeleccionada> {

  final VoluntariadoService _voluntariadoService = VoluntariadoService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return SerManosStatusBarWidget(
      statusBarColor: AppColors.neutralBlack,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: AppColors.neutralWhite
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: FutureBuilder<List<dynamic>>(
          future: Future.wait([
            widget.voluntariado,
            widget.loggedUser
          ]),
          builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasData && snapshot.data != null) {
                final Voluntariado voluntariado = snapshot.data![0];
                final SerManosUser loggedUser = snapshot.data![1];
                return SingleChildScrollView(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 243,
                          child: FittedBox(
                            clipBehavior: Clip.hardEdge,
                            fit: BoxFit.fitHeight,
                            child: Image.network(voluntariado.pictureDownloadUrl),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                voluntariado.tipoDeVoluntariado,
                                style: MyTheme.overline(),
                              ),
                              Text(
                                voluntariado.titulo,
                                style: MyTheme.headline01(),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                voluntariado.descripcionCorta,
                                style: MyTheme.body01(color: AppColors.secondaryBlue200),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                AppLocalizations.of(context)!.aboutTheActivity,
                                style: MyTheme.headline02(),
                              ),
                              Text(
                                voluntariado.descripcionLarga,
                                style: MyTheme.body01(),
                              ),
                              const SizedBox(height: 24),
                              CardUbicacion(
                                titulo: AppLocalizations.of(context)!.location,
                                label1: AppLocalizations.of(context)!.address,
                                content1: voluntariado.direccion,
                                latitude: voluntariado.ubicacion.latitude,
                                longitude: voluntariado.ubicacion.longitude,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                  AppLocalizations.of(context)!.participateInVolunteering,
                                style: MyTheme.headline02(),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                  AppLocalizations.of(context)!.requirements,
                                style: MyTheme.subtitle01(),
                              ),
                              const SizedBox(height: 8),
                              MarkdownBody(data: voluntariado.requisitos,),
                              const SizedBox(height: 8),
                              Text(
                                AppLocalizations.of(context)!.availability,
                                style: MyTheme.subtitle01(),
                              ),
                              const SizedBox(height: 8),
                              MarkdownBody(
                                data: voluntariado.disponibilidad,
                              ),
                              const SizedBox(height: 8),
                              Vacantes(vacantes: voluntariado.vacantes),
                              const SizedBox(height: 8),
                              Text(
                                AppLocalizations.of(context)!.dateOfCreation
                                    + ': '
                                    + SerManosDateUtils.dateFormatter(context).format(voluntariado.createdDate),
                                style: MyTheme.subtitle01(),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                AppLocalizations.of(context)!.cost
                                    + ': '
                                    + CurrencyUtils.currencyFormatter().format(voluntariado.costo)
                                    + ' '
                                    + AppLocalizations.of(context)!.argentinianPesos,
                                style: MyTheme.subtitle01(),
                              ),
                              const SizedBox(height: 24),
                              _getPostulacionState(voluntariado, loggedUser),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }
        ) ,
      ),
    );
  }

  Widget _getPostulacionState(Voluntariado voluntariado, SerManosUser loggedUser) {
    if(voluntariado.vacantes == 0) {
      return _noVacantes();
    } else if(voluntariado.postulados.contains(_authService.currentUser!.id)) {
      // El usuario logueado ya esta postulado a este voluntariado
      if(voluntariado.aceptados.contains(_authService.currentUser!.id)) {
        // El usuario ademas ya fue aceptado al voluntariado
        return _userAceptadoAlVoluntariado(voluntariado);
      } else {
        return _usuarioPostuladoAlVoluntariado(voluntariado);
      }
    } else {
      if(loggedUser.postulacion == null) {
        // El usuario no esta postulado a ningun voluntariado
        return _usuarioNoPostuladoANingunVoluntariado(voluntariado);
      } else {
        // El usuario esta postulado a otro voluntariado
        return _usuarioPostuladoAOtroVoluntariado(voluntariado, loggedUser);
      }
    }
  }

  Widget _noVacantes() {
    return Column(
      children: [
        Text(
        AppLocalizations.of(context)!.noRemainingPlaces,
          style: MyTheme.body01(),
        ),
        const SizedBox(height: 24,),
        ButtonCTAFilled(
          onPressed: null,
          buttonText: AppLocalizations.of(context)!.apply2,
          disabled: true
        ),
      ],
    );
  }

  Widget _usuarioPostuladoAlVoluntariado(Voluntariado voluntariado) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
        AppLocalizations.of(context)!.youHaveApplied,
          style: MyTheme.headline02(),
        ),
        const SizedBox(height: 8,),
        Text(
    AppLocalizations.of(context)!.youWillHearSoon,
          style: MyTheme.body01(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8,),
        ButtonCTANotFilled(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => Modal(
              modalBody: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  AppLocalizations.of(context)!.areYouSureYouWantToWithdrawYourApplication,
                    style: MyTheme.subtitle01(),
                  ),
                  Text(
                    voluntariado.titulo,
                    style: MyTheme.headline02(),
                  ),
                ],
              ),
              buttonOneText: AppLocalizations.of(context)!.cancel,
              buttonTwoText: AppLocalizations.of(context)!.confirm,
              onPressedButtonOne: () {
                Navigator.pop(context);
              },
              onPressedButtonTwo: () async {
                await _voluntariadoService.postularseAVoluntariado(
                    voluntariadoId: voluntariado.id,
                    postularse: false,
                    currentVacantes: voluntariado.vacantes
                );
                Navigator.pop(context);
                context.goNamed('voluntariado', pathParameters: {'voluntariadoId': voluntariado.id});
              },
            ),
          ),
          buttonText: AppLocalizations.of(context)!.withdrawApplication,
          disabled: false
        ),
      ],
    );
  }

  Widget _usuarioNoPostuladoANingunVoluntariado(Voluntariado voluntariado) {
    return ButtonCTAFilled(
      buttonText: AppLocalizations.of(context)!.apply2,
      onPressed: () => showDialog(
        context: context,
        builder: (context) => Modal(
          modalBody: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              AppLocalizations.of(context)!.youAreAboutToApplyTo,
                style: MyTheme.subtitle01(),
              ),
              Text(
                voluntariado.titulo,
                style: MyTheme.headline02(),
              ),
            ],
          ),
          buttonOneText: AppLocalizations.of(context)!.cancel,
          buttonTwoText: AppLocalizations.of(context)!.confirm,
          onPressedButtonOne: () {
            Navigator.pop(context);
          },
          onPressedButtonTwo: () async {
            await _voluntariadoService.postularseAVoluntariado(
                voluntariadoId: voluntariado.id,
                postularse: true,
                currentVacantes: voluntariado.vacantes
            );
            Navigator.pop(context);
            context.goNamed('voluntariado', pathParameters: {'voluntariadoId': voluntariado.id});
          },
        ),
      ),
      disabled: false,
    );
  }

  Widget _usuarioPostuladoAOtroVoluntariado(Voluntariado voluntariado, SerManosUser loggedUser) {
    return Column(
      children: [
        Text(
        AppLocalizations.of(context)!.youAreParticipatingInAnotherVolunteering,
          style: MyTheme.body01(),
        ),
        const SizedBox(height: 8,),
        ButtonCTANotFilled(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => Modal(
                modalBody: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                  AppLocalizations.of(context)!.areYouSureYouWantToAbandonThisVolunteering,
                      style: MyTheme.subtitle01(),
                    ),
                  ],
                ),
                buttonOneText: AppLocalizations.of(context)!.cancel,
                buttonTwoText: AppLocalizations.of(context)!.confirm,
                onPressedButtonOne: () {
                  Navigator.pop(context);
                },
                onPressedButtonTwo: () async {
                  await _voluntariadoService.postularseAVoluntariado(
                      voluntariadoId: loggedUser.postulacion!.id,
                      postularse: false,
                      currentVacantes: loggedUser.postulacion!.vacantes
                  );
                  Navigator.pop(context);
                  context.goNamed('voluntariado', pathParameters: {'voluntariadoId': voluntariado.id});
                },
              ),
            ),
            buttonText: AppLocalizations.of(context)!.abandonCurrentVolunteering,
            disabled: false
        ),
        const SizedBox(height: 24,),
        ButtonCTAFilled(
          onPressed: null,
          buttonText: AppLocalizations.of(context)!.apply2,
          disabled: true
        ),
      ],
    );
  }

  Widget _userAceptadoAlVoluntariado(Voluntariado voluntariado) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
        AppLocalizations.of(context)!.youAreParticipating,
          style: MyTheme.headline02(),
        ),
        const SizedBox(height: 8,),
        Text(
          AppLocalizations.of(context)!.theOrganizationConfirmedThatYouAreParticipatingInThisVolunteering,
          style: MyTheme.body01(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8,),
        ButtonCTANotFilled(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => Modal(
                modalBody: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                    AppLocalizations.of(context)!.areYouSureYouWantToAbandonThisVolunteering,
                      style: MyTheme.subtitle01(),
                    ),
                    Text(
                      voluntariado.titulo,
                      style: MyTheme.headline02(),
                    ),
                  ],
                ),
                buttonOneText: AppLocalizations.of(context)!.cancel,
                buttonTwoText: AppLocalizations.of(context)!.confirm,
                onPressedButtonOne: () {
                  Navigator.pop(context);
                },
                onPressedButtonTwo: () async {
                  await _voluntariadoService.postularseAVoluntariado(
                      voluntariadoId: voluntariado.id,
                      postularse: false,
                      currentVacantes: voluntariado.vacantes
                  );
                  Navigator.pop(context);
                  context.goNamed('voluntariado', pathParameters: {'voluntariadoId': voluntariado.id});
                },
              ),
            ),
            buttonText: AppLocalizations.of(context)!.abandonCurrentVolunteering,
            disabled: false
        ),
      ],
    );
  }

}
