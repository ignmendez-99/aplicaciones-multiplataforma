import 'package:aplicaciones_multiplataforma/design_system/atoms/logo_cuadrado.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/inputs.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/colors.dart';
import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleLoginButtonState() {
    setState(() {
      _isLoginButtonDisabled = !_formKey.currentState!.validate();
    });
  }

  bool _validLoginData() {
    return _passwordController.value.text.isNotEmpty && _emailController.value.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 147),
                const LogoCuadrado(),
                const SizedBox(height: 32),
                Input1(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El email es requerido';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if( _validLoginData() && _isLoginButtonDisabled ) {
                      _toggleLoginButtonState();
                    } else if( !_validLoginData() && !_isLoginButtonDisabled ) {
                      _toggleLoginButtonState();
                    }
                  },
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Email',
                  obscureText: false,
                  enabled: true,
                ),
                const SizedBox(height: 24),
                Input1(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La contraseña es requerida';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if( _validLoginData() && _isLoginButtonDisabled ) {
                      setState(() {
                        _toggleLoginButtonState();
                      });
                    } else if( !_validLoginData() && !_isLoginButtonDisabled ) {
                      setState(() {
                        _toggleLoginButtonState();
                      });
                    }
                  },
                  controller: _passwordController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Contraseña',
                  obscureText: true,
                  enabled: true,
                ),
                const SizedBox(height: 147),
                _isLoginButtonDisabled ?
                    const ButtonCTAFilledDisabled(buttonText: 'Iniciar Sesión',)
                    :
                    ButtonCTAFilled(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pushReplacementNamed('/welcome');
                        }
                      },
                      buttonText: 'Iniciar Sesión',
                    ),
                const SizedBox(height: 16),
                ButtonCTANotFilled(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/register');
                  },
                  buttonText: 'No tengo cuenta',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
