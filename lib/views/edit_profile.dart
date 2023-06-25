import 'dart:io';
import 'dart:ui';

import 'package:aplicaciones_multiplataforma/design_system/atoms/icons.dart';
import 'package:aplicaciones_multiplataforma/design_system/celulas/card_foto_de_perfil.dart';
import 'package:aplicaciones_multiplataforma/design_system/celulas/card_input.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/ser_manos_text_field.dart';
import 'package:aplicaciones_multiplataforma/services/auth/auth_service.dart';
import 'package:aplicaciones_multiplataforma/services/user_service.dart';
import 'package:aplicaciones_multiplataforma/utils/email_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../design_system/atoms/status_bar.dart';
import '../design_system/molecules/date_input_field.dart';
import '../design_system/tokens/colors.dart';
import '../design_system/tokens/typography.dart';
import '../models/user.dart';
import '../utils/date_utils.dart';
import '../utils/snackbar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
    required this.loggedUser,
  });

  final Future<SerManosUser> loggedUser;

  @override
  State<EditProfile> createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {

  late TextEditingController? _phoneController = null;
  late TextEditingController? _emailController = null;
  late TextEditingController? _birthdateController = null;
  final _formKey = GlobalKey<FormState>();
  final DateTime _anioMaximo = DateTime.now();
  final DateTime _anioMinimo = DateTime(1900);
  bool _isSaveChangesButtonDisabled = true;
  String? genero;
  File? _profilePicture;
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();

  bool _validEditProfileData() {
    return _formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return SerManosStatusBarWidget(
      statusBarColor: AppColors.neutralWhite,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: MyIcons.closeEnabled,
            onPressed: () {
              context.goNamed('miPerfil');
            },
          ),
        ),
        body: FutureBuilder(
          future: widget.loggedUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasData && snapshot.data != null) {
              final SerManosUser user = snapshot.data!;
              _phoneController ??= TextEditingController(text: user.phone);
              _emailController ??= TextEditingController(text: user.email);
              _birthdateController ??= TextEditingController(
                  text: user.birthdate != null ?
                      SerManosDateUtils.dateFormatter(context).format(user.birthdate!)
                      : null
              );

              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.profileData,
                          style: MyTheme.headline01(),
                        ),
                        const SizedBox(height: 24,),
                        DateInputField(
                          validator: _validateBirthdayDate,
                          anioMinimo: _anioMinimo,
                          anioMaximo: _anioMaximo,
                          onChanged: _onChangeInput,
                          controller: _birthdateController!,
                        ),
                        const SizedBox(height: 24,),
                        CardInput(
                          genderInitialValue: user.gender,
                          onChanged: (value) {
                            _onChangeInput(value);
                            setState(() {
                              genero = value;
                            });
                          },
                        ),
                        const SizedBox(height: 24,),
                        CardFotoDePerfil(
                          initialPictureDownloadUrl: user.profilePictureDownloadUrl,
                          onChanged: (value) {
                            _onChangeInput('');
                            setState(() {
                              _profilePicture = value;
                            });
                          }
                        ),
                        const SizedBox(height: 32,),
                        Text(
                          AppLocalizations.of(context)!.contactData,
                          style: MyTheme.headline01(),
                        ),
                        const SizedBox(height: 24,),
                        Text(
                          AppLocalizations.of(context)!.dataShare,
                          style: MyTheme.subtitle01(),
                        ),
                        const SizedBox(height: 24,),
                        SerManosTextField(
                          controller: _phoneController!,
                          keyboardType: TextInputType.number,
                          labelText: AppLocalizations.of(context)!.phone,
                          validator: _validatePhoneNumber,
                          hintText: '${AppLocalizations.of(context)!.exampleAbbreviation}: +541178445459',
                          onChanged: _onChangeInput,
                        ),
                        const SizedBox(height: 24,),
                        SerManosTextField(
                          controller: _emailController!,
                          keyboardType: TextInputType.emailAddress,
                          labelText: AppLocalizations.of(context)!.email2,
                          validator: _validateEmail,
                          hintText: '${AppLocalizations.of(context)!.exampleAbbreviation}: liomessi@gmail.com',
                          onChanged: _onChangeInput,
                        ),
                        const SizedBox(height: 30,),
                        ButtonCTAFilled(
                          onPressed: () async {
                            if(_validEditProfileData()) {
                              setState(() {
                                _isSaveChangesButtonDisabled = true;
                              });
                              final birthDate = getBirthdate(_birthdateController!.text);
                              final phone = _phoneController!.text;
                              final email = _emailController!.text;
                              var response = await _userService.updateUser(
                                phone: phone,
                                birthdate: birthDate,
                                email: email,
                                gender: genero,
                                profilePicture: _profilePicture,
                                userId: _authService.currentUser!.id,
                                context: context
                              );
                              setState(() {
                                _isSaveChangesButtonDisabled = false;
                              });
                              if(response['result'] == 'error') {
                                await CustomSnackbar.showSnackbar(context: context, detail: response['detail']!);
                              } else {
                                context.goNamed('miPerfil');
                              }
                            }
                          },
                          buttonText: AppLocalizations.of(context)!.saveData,
                          disabled: _isSaveChangesButtonDisabled,
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  void _onChangeInput(String value) {
    final bool allFormValid = _validEditProfileData();
    setState(() {
      _isSaveChangesButtonDisabled = !allFormValid;
    });
  }

  String? _validatePhoneNumber(String? input) {
    if(input == null || input.isEmpty) {
      return AppLocalizations.of(context)!.phoneNeeded;
    }
    if(input.length < 8) {
      return AppLocalizations.of(context)!.phoneMinLength;
    }
    return null;
  }

  String? _validateEmail(String? input) {
    if(input == null || input.isEmpty) {
      return AppLocalizations.of(context)!.mailNeeded;
    }
    if(!EmailUtils.validateEmail(input)) {
      return AppLocalizations.of(context)!.invalidEmail;
    }
    return null;
  }

  String? _validateBirthdayDate(String? input) {
    if(input == null || input.isEmpty) {
      return AppLocalizations.of(context)!.dateOfBirthNeeded;
    }
    if(input.length < 10) {
      // Todavia no terminó de escribir la fecha completa
      return AppLocalizations.of(context)!.dateFormat;
    }

    final parts = input.split('/');
    if (parts.length != 3) {
      return AppLocalizations.of(context)!.dateFormat;
    }

    int? day; int? month; int? year;

    Locale userLocale = window.locale;
    if(userLocale.languageCode == 'es') {
      day = int.tryParse(parts[0]);
      month = int.tryParse(parts[1]);
      year = int.tryParse(parts[2]);
    } else if(userLocale.languageCode == 'en') {
      day = int.tryParse(parts[1]);
      month = int.tryParse(parts[0]);
      year = int.tryParse(parts[2]);
    } else {
      throw Exception('No hay lenguaje disponible');
    }

    if (day == null || month == null || year == null) {
      return AppLocalizations.of(context)!.dateFormat;
    }

    try {
      final date = DateTime(year, month, day);
      if (date.day != day || date.month != month || date.year != year) {
        return AppLocalizations.of(context)!.dateFormat;
      }
      if(date.year < _anioMinimo.year || date.year > _anioMaximo.year) {
        return AppLocalizations.of(context)!.correctDate;
      }
    } catch (e) {
      return AppLocalizations.of(context)!.dateFormat;
    }

    return null;
  }

  DateTime? getBirthdate(String birthdate) {
    final List<String> parts = birthdate.split('/');
    if (parts.length != 3) {
      return null;
    }

    int? day; int? month; int? year;

    Locale userLocale = window.locale;
    if(userLocale.languageCode == 'es') {
      day = int.tryParse(parts[0]);
      month = int.tryParse(parts[1]);
      year = int.tryParse(parts[2]);
    } else if(userLocale.languageCode == 'en') {
      day = int.tryParse(parts[1]);
      month = int.tryParse(parts[0]);
      year = int.tryParse(parts[2]);
    } else {
      throw Exception('No hay lenguaje disponible');
    }

    if (day == null || month == null || year == null) {
      return null;
    }
    try {
      final date = DateTime(year, month, day);
      if (date.day != day || date.month != month || date.year != year) {
        return null;
      }
      return date;
    } catch (e) {
      return null;
    }
  }
}
