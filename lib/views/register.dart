import 'package:aplicaciones_multiplataforma/design_system/atoms/status_bar.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/inputs_2.dart';
import 'package:aplicaciones_multiplataforma/utils/email_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../design_system/tokens/colors.dart';
import '../services/auth/auth_service.dart';
import '../utils/snackbar.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isSignupButtonDisabled = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validSignupData() {
    return _formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return SerManosStatusBarWidget(
      statusBarColor: AppColors.neutralWhite,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Image.asset(
                    "assets/images/SER MANOS LOGO_Mesa de trabajo 1.png",
                    height: 150,
                    width: 150,
                  ),
                  const SizedBox(height: 31,),
                  Input2(
                    controller: _firstNameController,
                    keyboardType: TextInputType.text,
                    labelText: AppLocalizations.of(context)!.name,
                    validator: _validateFirstName,
                    onChanged: _onChangeInput,
                    hintText: '${AppLocalizations.of(context)!.exampleAbbreviation}: Juan',
                  ),
                  const SizedBox(height: 24,),
                  Input2(
                    controller: _lastNameController,
                    keyboardType: TextInputType.text,
                    labelText: AppLocalizations.of(context)!.surname,
                    validator: _validateLastName,
                    onChanged: _onChangeInput,
                    hintText: '${AppLocalizations.of(context)!.exampleAbbreviation}: Barcena',
                  ),
                  const SizedBox(height: 24,),
                  Input2(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    labelText: AppLocalizations.of(context)!.email2,
                    validator: _validateEmail,
                    onChanged: _onChangeInput,
                    hintText: '${AppLocalizations.of(context)!.exampleAbbreviation}: juanbarcena@mail.com',
                  ),
                  const SizedBox(height: 24,),
                  PasswordInputField(
                    controller: _passwordController,
                    labelText: AppLocalizations.of(context)!.password,
                    validator: _validatePassword,
                    onChanged: _onChangeInput,
                    hintText: '${AppLocalizations.of(context)!.exampleAbbreviation}: ABCD1234',
                  ),
                  const Spacer(),
                  ButtonCTAFilled(
                    onPressed: () async {
                      if (_validSignupData()) {
                        setState(() {
                          _isSignupButtonDisabled = true;
                        });
                        final firstName = _firstNameController.text;
                        final lastName = _lastNameController.text;
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        var response = await _authService.signUp(
                          email: email,
                          password: password,
                          firstName: firstName,
                          lastName: lastName,
                        );
                        setState(() {
                          _isSignupButtonDisabled = false;
                        });
                        if(response['result'] == 'error') {
                          await CustomSnackbar.showSnackbar(context: context, detail: response['detail']!);
                        } else {
                          context.goNamed('welcome');
                        }
                      }
                    },
                    buttonText: AppLocalizations.of(context)!.register,
                    disabled: _isSignupButtonDisabled
                  ),
                  const SizedBox(height: 16),
                  ButtonCTANotFilled(
                    onPressed: () {
                      context.goNamed('login');
                    },
                    buttonText: AppLocalizations.of(context)!.haveAccountMessage,
                    disabled: false,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onChangeInput(String value) {
    final bool allFormValid = _validSignupData();
    if(allFormValid && _isSignupButtonDisabled ) {
      setState(() {
        _isSignupButtonDisabled = false;
      });
    } else if(!allFormValid && !_isSignupButtonDisabled ) {
      setState(() {
        _isSignupButtonDisabled = true;
      });
    }
  }

  String? _validateFirstName(String? input) {
    if(input == null || input.isEmpty) {
      return AppLocalizations.of(context)!.nameNeeded;
    }
    if(input.length < 3) {
      return AppLocalizations.of(context)!.nameMinLength;
    }
    return null;
  }

  String? _validateLastName(String? input) {
    if(input == null || input.isEmpty) {
      return AppLocalizations.of(context)!.surnameNeeded;
    }
    if(input.length < 3) {
      return AppLocalizations.of(context)!.surnameMinLength;
    }
    return null;
  }

  String? _validateEmail(String? input) {
    if(input == null || input.isEmpty) {
      return AppLocalizations.of(context)!.mailNeeded;
    }
    if(!EmailUtils.validateEmail(input)) {
      return 'Email inválido';
    }
    return null;
  }

  String? _validatePassword(String? input) {
    if(input == null || input.isEmpty) {
      return AppLocalizations.of(context)!.passwordNeeded;
    }
    if(input.length < 8) {
      return 'Contraseña muy corta';
    }
    return null;
  }
}