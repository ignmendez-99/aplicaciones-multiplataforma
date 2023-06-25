import 'package:flutter/material.dart';

import '../tokens/colors.dart';
import '../tokens/typography.dart';

class ButtonCTA extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
  final Color? backgroundColor;
  final Color textColor;

  const ButtonCTA({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4), // todo: falta ver bien como poner el radio del Figma
      child: TextButton(
        onPressed: onPressed,
        child: Container(
          color: backgroundColor,
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
          child: Center(
            child: Text(
              buttonText,
              style: MyTheme.button(color: textColor),
            ),
          ),
        )
      ),
    );
  }
}

class ButtonCTAFilled extends ButtonCTA {
  const ButtonCTAFilled({
    super.key,
    required void Function()? onPressed,
    required String buttonText,
    required bool disabled,
    Color? textColor,
  }) : super(
    onPressed: disabled ? null : onPressed,
    buttonText: buttonText,
    backgroundColor: disabled ? AppColors.neutralGrey25 : AppColors.primary100,
    textColor: textColor ?? (disabled ? AppColors.neutralGrey50 : AppColors.neutralWhite),
  );
}

class ButtonCTANotFilled extends ButtonCTA {
  const ButtonCTANotFilled({
    super.key,
    required void Function()? onPressed,
    required String buttonText,
    required bool disabled,
    Color? textColor,
  }) : super(
    onPressed: disabled ? null : onPressed,
    buttonText: buttonText,
    backgroundColor: null,
    textColor: textColor ?? (disabled ? AppColors.neutralGrey50 : AppColors.primary100),
  );
}
