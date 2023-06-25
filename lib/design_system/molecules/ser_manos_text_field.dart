import 'package:flutter/material.dart';

import '../atoms/icons.dart';

class SerManosTextField extends StatefulWidget {

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String labelText;
  final String? hintText;
  final bool obscureText;
  // final bool enabled;

  const SerManosTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
    required this.validator,
    this.hintText,
    this.obscureText = false,
    required this.onChanged
  });

  @override
  State<SerManosTextField> createState() => _SerManosTextFieldState();
}

class _SerManosTextFieldState extends State<SerManosTextField> {

  bool _showClearIcon = false;
  bool _showErrorIcon = false;
  bool _showVisibilityIcon = false;
  late bool _obscureText;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(controllerListener);
    _obscureText = widget.obscureText;
    _showVisibilityIcon = widget.obscureText;
  }

  void controllerListener() {
    setState(() {
      _showClearIcon = widget.controller.text.isNotEmpty && !widget.obscureText;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(controllerListener);
    widget.controller.dispose();
    super.dispose();
  }

  String? _validator(String? input) {
    var validated = widget.validator!(input);
    if(validated != null) {
      setState((){
        _showErrorIcon = true;
      });
      return validated;
    } else {
      setState((){
        _showErrorIcon = false;
      });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: _validator,
      onChanged: _onChangedInput,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      decoration: InputDecoration(
        errorText: _errorText,
        border: const OutlineInputBorder(),
        labelText: widget.labelText,
        hintText: widget.hintText,
        floatingLabelBehavior: widget.hintText != null ? FloatingLabelBehavior.always : FloatingLabelBehavior.auto,
        suffixIcon: _getSuffixIcon(),
      )
    );
  }

  Widget? _getSuffixIcon() {
    if(_showErrorIcon) {
      return MyIcons.errorActivated;
    } else if(_showClearIcon) {
      return GestureDetector(
        onTap: () {
          setState(() {
            widget.controller.clear();
            _onChangedInput('');
            _showClearIcon = false;
          });
        },
        child: MyIcons.closeEnabled,
      );
    } else if(_showVisibilityIcon) {
      Icon icon;
      if(_obscureText) {
        icon = MyIcons.visibilityOffEnabled;
      } else {
        icon = MyIcons.visibilityEnabled;
      }
      return GestureDetector(
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        child: icon,
      );
    } else {
      return null;
    }
  }

  void _onChangedInput(String input) {
    widget.onChanged!(input);
    setState(() {
      _errorText = _validator(input);
    });
  }
}

class PasswordInputField extends SerManosTextField{
  const PasswordInputField({
    super.key,
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?)? validator,
    String? hintText,
    required void Function(String)? onChanged
  }) : super(
    controller: controller,
    keyboardType: TextInputType.visiblePassword,
    labelText: labelText,
    validator: validator,
    hintText: hintText,
    obscureText: true,
    onChanged: onChanged,
  );
}
