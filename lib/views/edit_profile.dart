import 'dart:io';

import 'package:aplicaciones_multiplataforma/design_system/celulas/card_foto_de_perfil.dart';
import 'package:aplicaciones_multiplataforma/design_system/celulas/card_input.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/inputs_2.dart';
import 'package:aplicaciones_multiplataforma/services/auth/auth_service.dart';
import 'package:aplicaciones_multiplataforma/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../design_system/atoms/status_bar.dart';
import '../design_system/molecules/date_input_field.dart';
import '../design_system/tokens/colors.dart';
import '../design_system/tokens/typography.dart';
import '../models/user.dart';
import '../utils/date_utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
    required this.loggedUser,
  });

  final Future<User> loggedUser;

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
        ),
        body: FutureBuilder(
          future: widget.loggedUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasData && snapshot.data != null) {
              final User user = snapshot.data!;
              _phoneController ??= TextEditingController(text: user.phone);
              _emailController ??= TextEditingController(text: user.email);
              _birthdateController ??= TextEditingController(
                  text: user.birthdate != null ?
                      SerManosDateUtils.dateFormatter.format(user.birthdate!)
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
                          'Datos de perfil',
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
                          'Datos de contacto',
                          style: MyTheme.headline01(),
                        ),
                        const SizedBox(height: 24,),
                        Text(
                          'Estos datos serán compartidos con la organización para ponerse en contacto contigo',
                          style: MyTheme.subtitle01(),
                        ),
                        const SizedBox(height: 24,),
                        Input2(
                          controller: _phoneController!,
                          keyboardType: TextInputType.number,
                          labelText: 'Teléfono',
                          validator: _validatePhoneNumber,
                          hintText: 'Ej: +541178445459',
                          onChanged: _onChangeInput,
                        ),
                        const SizedBox(height: 24,),
                        Input2(
                          controller: _emailController!,
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'Mail',
                          validator: _validateEmail,
                          hintText: 'Ej: mimail@mail.com',
                          onChanged: _onChangeInput,
                        ),
                        const SizedBox(height: 30,),
                        ButtonCTAFilled(
                          onPressed: () async {
                            if(_validEditProfileData()) {
                              final birthDate = getBirthdate(_birthdateController!.text);
                              final phone = _phoneController!.text;
                              final email = _emailController!.text;
                              await _userService.updateUser(
                                phone: phone,
                                birthdate: birthDate,
                                email: email,
                                gender: genero,
                                profilePicture: _profilePicture,
                                userId: _authService.currentUser!.id,
                              );
                              context.goNamed('miPerfil');
                            }
                          },
                          buttonText: 'Guardar datos',
                          disabled: _isSaveChangesButtonDisabled,
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              // CASO IMPOSIBLE
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
      return 'El teléfono es obligatorio';
    }
    if(input.length < 8) {
      return 'El teléfono debe tener al menos 8 numeros';
    }
    return null;
  }

  String? _validateEmail(String? input) {
    if(input == null || input.isEmpty) {
      return 'El mail es obligatorio';
    }
    if(input.length < 3) {
      return 'El email debe tener al menos 3 caracteres';
    }
    return null;
  }

  String? _validateBirthdayDate(String? input) {
    if(input == null || input.isEmpty) {
      return 'La fecha de nacimiento es obligatoria';
    }
    if(input.length < 10) {
      // Todavia no terminó de escribir la fecha completa
      return 'Escriba fecha en formato DD/MM/YYYY';
    }

    final parts = input.split('/');
    if (parts.length != 3) {
      return 'Escriba fecha en formato DD/MM/YYYY';
    }

    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) {
      return 'Escriba fecha en formato DD/MM/YYYY';
    }

    try {
      final date = DateTime(year, month, day);
      if (date.day != day || date.month != month || date.year != year) {
        return 'Escriba fecha en formato DD/MM/YYYY';
      }
      if(date.year < _anioMinimo.year || date.year > _anioMaximo.year) {
        return 'Solo se acepta años mayores a 1900 y menores o iguales al año actual';
      }
    } catch (e) {
      return 'Escriba fecha en formato DD/MM/YYYY';
    }

    return null;
  }

  DateTime? getBirthdate(String birthdate) {
    final List<String> parts = birthdate.split('/');
    if (parts.length != 3) {
      return null;
    }
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
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
