import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/molecules/inputs_2.dart';
import 'package:aplicaciones_multiplataforma/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/auth/auth_service.dart';

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
  final UserService _userService = UserService();
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
    return Scaffold(
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
                  labelText: 'Nombre',
                  validator: _validateFirstName,
                  onChanged: _onChangeInput,
                  hintText: 'Ej: Juan',
                ),
                const SizedBox(height: 24,),
                Input2(
                  controller: _lastNameController,
                  keyboardType: TextInputType.text,
                  labelText: 'Apellido',
                  validator: _validateLastName,
                  onChanged: _onChangeInput,
                  hintText: 'Ej: Barcena',
                ),
                const SizedBox(height: 24,),
                Input2(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Email',
                  validator: _validateEmail,
                  onChanged: _onChangeInput,
                  hintText: 'Ej: juanbarcena@mail.com',
                ),
                const SizedBox(height: 24,),
                Input2(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  labelText: 'Contraseña',
                  validator: _validatePassword,
                  onChanged: _onChangeInput,
                  hintText: 'Ej: ABCD1234',
                  obscureText: true,
                ),
                const Spacer(),
                ButtonCTAFilled(
                  onPressed: () async {
                    if (_validSignupData()) {
                      final firstName = _firstNameController.text;
                      final lastName = _lastNameController.text;
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      await _authService.signUp(
                        email: email,
                        password: password,
                        firstName: firstName,
                        lastName: lastName,
                      );
                      context.goNamed('welcome');
                    }
                  },
                  buttonText: 'Registrarme',
                  disabled: _isSignupButtonDisabled
                ),
                const SizedBox(height: 16),
                ButtonCTANotFilled(
                  onPressed: () {
                    context.goNamed('login');
                  },
                  buttonText: 'Ya tengo cuenta',
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
      return 'El nombre es obligatorio';
    }
    if(input.length < 3) {
      return 'El nombre debe tener al menos 3 caracteres de largo';
    }
    return null;
  }

  String? _validateLastName(String? input) {
    if(input == null || input.isEmpty) {
      return 'El apellido es obligatorio';
    }
    if(input.length < 3) {
      return 'El apellido debe tener al menos 3 caracteres de largo';
    }
    return null;
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