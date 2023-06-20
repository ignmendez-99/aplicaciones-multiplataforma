import 'package:flutter/material.dart';

import '../atoms/icons.dart';

class Input2 extends StatefulWidget {

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String labelText;
  final String? hintText;
  final bool? obscureText;
  // final bool enabled;

  const Input2({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
    required this.validator,
    this.hintText,
    this.obscureText,
    required this.onChanged
  });

  @override
  State<Input2> createState() => _Input2State();
}

class _Input2State extends State<Input2> {

  bool _showClearIcon = false;
  bool _showErrorIcon = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        _showClearIcon = widget.controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
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
      obscureText: widget.obscureText ?? false,
      decoration: InputDecoration(
        errorText: _errorText,
        border: const OutlineInputBorder(),
        labelText: widget.labelText,
        hintText: widget.hintText,
        floatingLabelBehavior: widget.hintText != null ? FloatingLabelBehavior.always : FloatingLabelBehavior.auto,
        suffixIcon: _showErrorIcon ? MyIcons.errorActivated
            :
              _showClearIcon ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.controller.clear();
                    _onChangedInput('');
                    _showClearIcon = false;
                  });
                },
                child: MyIcons.closeEnabled,
              )
              :
              null,
      )
    );
  }

  void _onChangedInput(String input) {
    widget.onChanged!(input);
    setState(() {
      _errorText = _validator(input);
    });
  }
}
