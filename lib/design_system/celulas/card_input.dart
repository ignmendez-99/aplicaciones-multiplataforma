import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../atoms/icons.dart';
import '../tokens/colors.dart';
import '../tokens/typography.dart';

class CardInput extends StatefulWidget {

  final void Function(String)? onChanged;
  final String? genderInitialValue;

  const CardInput({
    super.key,
    required this.onChanged,
    this.genderInitialValue,
  });

  @override
  State<CardInput> createState() => _CardInputState();
}

class _CardInputState extends State<CardInput> {
  String? _selectedOption;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.genderInitialValue;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> generos = [AppLocalizations.of(context)!.genderMale, AppLocalizations.of(context)!.genderFemale, AppLocalizations.of(context)!.genderOther];
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
          color: AppColors.secondaryBlue25,
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.profileInformation,
                style: MyTheme.subtitle01(),
              ),
            ],
          ),
        ),
        Container(
          color: AppColors.neutralGrey10,
          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
          child: FormField(
            builder: (field) {
              return Column(
                children: [
                  Column(
                    children: List.generate(
                      generos.length,
                      (index) => CustomRadioButton(
                        label: generos[index],
                        isSelected: _selectedOption == generos[index],
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value ? generos[index] : null;
                            _errorText = _validateGenderRadioButton(_selectedOption);
                          });
                          field.didChange(value ? generos[index] : null);
                          widget.onChanged!(generos[index]);
                        },
                      )
                    ),
                  ),
                  _errorText != null ?
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          field.errorText!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                      :
                      Container(),
                ],
              );
            },
            validator: _validateGenderRadioButton,
          ),
        )
      ],
    );
  }

  String? _validateGenderRadioButton(String? input) {
    if (input == null && _selectedOption == null) {
      return AppLocalizations.of(context)!.genderNeeded;
    }
    return null;
  }
}

class CustomRadioButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function(bool) onChanged;

  const CustomRadioButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!isSelected),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(4, 4, 0, 4),
            child: isSelected ? MyIcons.radioButtonCheckedActivated : MyIcons.radioButtonUncheckedActivated
          ),
          const SizedBox(width: 8,),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 6, 4, 6),
            child: Text(
              label,
              style: MyTheme.body01(),
            ),
          ),
        ],
      ),
    );
  }
}
