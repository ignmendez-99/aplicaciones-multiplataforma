import 'package:aplicaciones_multiplataforma/design_system/atoms/logo_cuadrado.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/inputs_2.dart';
import 'package:aplicaciones_multiplataforma/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                Input2(
                  controller: _emailController,
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                  onChanged: _onChangeInput,
                ),
                const SizedBox(height: 24),
                Input2(
                  controller: _passwordController,
                  labelText: 'Contraseña',
                  keyboardType: TextInputType.text,
                  validator: _validatePassword,
                  obscureText: true,
                  onChanged: _onChangeInput,
                ),
                const Spacer(),
                ButtonCTAFilled(
                  buttonText: 'Iniciar Sesión',
                  onPressed: () async {
                    if (_validLoginData()) {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      await _authService.logIn(email: email, password: password);
                      context.goNamed('welcome');
                    }
                  },
                  disabled: _isLoginButtonDisabled,
                ),
                const SizedBox(height: 16),
                ButtonCTANotFilled(
                  onPressed: () {
                    context.goNamed('register');
                  },
                  buttonText: 'No tengo cuenta',
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
      return 'El mail es obligatorio';
    }
    if(input.length < 3) {
      return 'El email debe tener al menos 3 caracteres de largo';
    }
    return null;
  }

  String? _validatePassword(String? input) {
    if(input == null || input.isEmpty) {
      return 'La contraseña es obligatoria';
    }
    return null;
  }
}
