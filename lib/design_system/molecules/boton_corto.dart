import 'package:aplicaciones_multiplataforma/design_system/atoms/icons.dart';
import 'package:flutter/material.dart';

import '../tokens/colors.dart';
import '../tokens/typography.dart';

class ShortButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color backgroundColor;
  final Color textColor;

  const ShortButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4), //todo: falta ver bien como poner el radio del Figma
      child: TextButton(
        onPressed: onPressed,
        child: Container(
          color: AppColors.primary,
          width: 123,
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyIcons.addNeutralWhite,
              const SizedBox(width: 8,),
              Text(
                buttonText,
                style: MyTheme.button(color: textColor),
              )
            ],
          ),
        )
      ),
    );
  }
}

class ShortButtonActivated extends ShortButton {
  const ShortButtonActivated({
    super.key,
    required VoidCallback onPressed,
    required String buttonText,
  }) : super(
    onPressed: onPressed,
    buttonText: buttonText,
    backgroundColor: AppColors.primary,
    textColor: AppColors.neutralWhite,
  );
}

class ShortButtonDisabled extends ShortButton {
  const ShortButtonDisabled({
    super.key,
    required VoidCallback onPressed,
    required String buttonText,
  }) : super(
    onPressed: onPressed,
    buttonText: buttonText,
    backgroundColor: AppColors.neutralGrey25,
    textColor: AppColors.neutralGrey50,
  );
}