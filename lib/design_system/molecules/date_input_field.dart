import 'package:aplicaciones_multiplataforma/design_system/atoms/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateInputField extends StatefulWidget {

  final void Function(String)? onChanged;
  final DateTime anioMinimo;
  final DateTime anioMaximo;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const DateInputField({
    super.key,
    required this.validator,
    required this.anioMinimo,
    required this.anioMaximo,
    required this.onChanged,
    required this.controller,
  });

  @override
  DateInputFieldState createState() => DateInputFieldState();
}

class DateInputFieldState extends State<DateInputField> {
  DateTime? _selectedDate;
  final _dateMaskFormatter = DateMaskTextInputFormatter();
  String? _errorText;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: widget.anioMinimo,
      lastDate: widget.anioMaximo,
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.controller.text = DateFormat('dd/MM/yyyy').format(picked);
        widget.onChanged!(widget.controller.text);
      });
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [_dateMaskFormatter],
      validator: widget.validator,
      onChanged: _onChangedInput,
      decoration: InputDecoration(
        helperText: 'DD/MM/YYYY',
        errorText: _errorText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: AppLocalizations.of(context)!.dateOfBirth,
        hintText: 'DD/MM/YYYY',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: MyIcons.calendarMonthTwoTonesActivated,
          onPressed: () => _selectDate(context),
        ),
      ),
      controller: widget.controller,
    );
  }

  void _onChangedInput(String input) {
    widget.onChanged!(input);
    setState(() {
      _errorText = widget.validator!(input);
    });
  }
}

class DateMaskTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    const maxLength = 8;
    var selectionIndex = newValue.selection.end;

    var dateText = newValue.text.replaceAll("/", "");
    var formattedDate = "";

    if (dateText.length > maxLength) {
      dateText = dateText.substring(0, maxLength);
    }

    var index = 0;
    while (index < dateText.length) {
      if (index == 2 || index == 4) {
        formattedDate += "/";
      }
      formattedDate += dateText.substring(index, index + 1);
      index++;
    }

    selectionIndex += formattedDate.length - newValue.text.length;

    return TextEditingValue(
      text: formattedDate,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}