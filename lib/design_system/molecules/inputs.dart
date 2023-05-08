import 'package:aplicaciones_multiplataforma/design_system/atoms/icons.dart';
import 'package:flutter/material.dart';

import '../tokens/colors.dart';
import '../tokens/typography.dart';

// TODO TODAVIA FALTA LO DEL PLACEHOLDER

class Input1 extends StatefulWidget {
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String labelText;
  final bool obscureText;
  final bool enabled;

  const Input1({
    super.key,
    required this.validator,
    required this.onChanged,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
    required this.obscureText,
    required this.enabled,
  });

  @override
  State<Input1> createState() => _Input1State();
}

class _Input1State extends State<Input1> {
  bool _showClearIcon = false;
  bool _showErrorIcon = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(() {
      setState(() {
        _showClearIcon = widget.controller!.text.isNotEmpty;
      });
    });
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      setState(() {
        _showClearIcon = false;
      });
    } else if(widget.controller!.text.isEmpty){
      setState(() {
        _showClearIcon = false;
      });
    } else {
      setState(() {
        _showClearIcon = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      focusNode: _focusNode,
      decoration: InputDecoration(
        suffixIcon: getSuffixIcon(),
        labelText: widget.labelText,
        labelStyle: MyTheme.subtitle01(color: null), /// Toma el color del border
        // hintText: 'Placeholder',
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.neutralGrey75,),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.secondaryBlue200,),
        ),
      ),
      obscureText: widget.obscureText,
      style: MyTheme.subtitle01(),
      validator: (value) {
        var validated = widget.validator!(value);
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
      },
      onChanged: widget.onChanged,
    );
  }

  Widget? getSuffixIcon() {
    if(_showErrorIcon) {
      return MyIcons.errorActivated;
    }
    if(_showClearIcon) {
      return GestureDetector(
        onTap: () {
          setState(() {
            widget.controller?.clear();
            _showClearIcon = false;
          });
        },
        child: MyIcons.closeEnabled,
      );
    }
    return null;
  }
}

class Input2 extends Input1 {
  const Input2({
    super.key,
    required String? Function(String?)? validator,
    required void Function(String)? onChanged,
    required TextEditingController? controller,
    required TextInputType? keyboardType,
    required String labelText,
    required bool obscureText,
    required bool enabled,
  }) : super(
    validator: validator,
    onChanged: onChanged,
    controller: controller,
    keyboardType: keyboardType,
    labelText: labelText,
    obscureText: obscureText,
    enabled: enabled
  );
}