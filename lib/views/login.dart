import 'package:aplicaciones_multiplataforma/design_system/atoms/logo_cuadrado.dart';
import 'package:aplicaciones_multiplataforma/design_system/atoms/status_bar.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/ser_manos_text_field.dart';
import 'package:aplicaciones_multiplataforma/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../design_system/tokens/colors.dart';
import '../utils/email_utils.dart';
import '../utils/snackbar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoginButtonDisabled = true;
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validLoginData() {
    return _formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return SerManosStatusBarWidget(
      statusBarColor: AppColors.neutralWhite,
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Spacer(),
                      const LogoCuadrado(),
                      const SizedBox(height: 32),
                      SerManosTextField(
                        controller: _emailController,
                        labelText: AppLocalizations.of(context)!.email2,
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                        onChanged: _onChangeInput,
                      ),
                      const SizedBox(height: 24),
                      PasswordInputField(
                        controller: _passwordController,
                        labelText: AppLocalizations.of(context)!.password,
                        validator: _validatePassword,
                        onChanged: _onChangeInput,
                      ),
                      const Spacer(),
                      ButtonCTAFilled(
                        buttonText: AppLocalizations.of(context)!.login,
                        onPressed: () async {
                          if (_validLoginData()) {
                            setState(() {
                              _isLoginButtonDisabled = true;
                            });
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            var response = await _authService.logIn(
                              email: email,
                              password: password,
                              context: context
                            );
                            setState(() {
                              _isLoginButtonDisabled = false;
                            });
                            if(response['result'] == 'error') {
                              await CustomSnackbar.showSnackbar(context: context, detail: response['detail']!);
                            } else {
                              context.goNamed('welcome');
                            }
                          }
                        },
                        disabled: _isLoginButtonDisabled,
                      ),
                      const SizedBox(height: 16),
                      ButtonCTANotFilled(
                        onPressed: () {
                          context.goNamed('register');
                        },
                        buttonText: AppLocalizations.of(context)!.dontHaveAccountMessage,
                        disabled: false,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  void _onChangeInput(String value) {
    final bool allFormValid = _validLoginData();
    if(allFormValid && _isLoginButtonDisabled ) {
      setState(() {
        _isLoginButtonDisabled = false;
      });
    } else if(!allFormValid && !_isLoginButtonDisabled ) {
      setState(() {
        _isLoginButtonDisabled = true;
      });
    }
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

  String? _validatePassword(String? input) {
    if(input == null || input.isEmpty) {
      return AppLocalizations.of(context)!.passwordNeeded;
    }
    if(input.length < 8) {
      return AppLocalizations.of(context)!.weakPassword;
    }
    return null;
  }
}
