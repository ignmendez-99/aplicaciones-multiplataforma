import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 50),
          Image.asset(
            "assets/images/logo_cuadrado.png",
            height: 200,
            width: 200,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El email es requerido';
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
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Contraseña'),
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
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text('Iniciar Sesión'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pushNamed(context, '/welcome');
              }
            },
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            child: const Text('No tengo cuenta'),
          ),
        ],
      ),
    );
  }
}
