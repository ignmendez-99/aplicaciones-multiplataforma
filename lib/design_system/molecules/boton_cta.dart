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
      borderRadius: BorderRadius.circular(4), //todo: falta ver bien como poner el radio del Figma
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          overlayColor: MaterialStateColor.resolveWith((states) => AppColors.neutralGrey10),
        ),
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
  }) : super(
    onPressed: onPressed,
    buttonText: buttonText,
    backgroundColor: AppColors.primary100,
    textColor: AppColors.neutralWhite,
  );
}

class ButtonCTAFilledDisabled extends ButtonCTA {
  const ButtonCTAFilledDisabled({
    super.key,
    required String buttonText,
  }) : super(
    onPressed: null,
    buttonText: buttonText,
    backgroundColor: AppColors.neutralGrey25,
    textColor: AppColors.neutralGrey50,
  );
}

class ButtonCTANotFilled extends ButtonCTA {
  const ButtonCTANotFilled({
    super.key,
    required void Function()? onPressed,
    required String buttonText,
  }) : super(
    onPressed: onPressed,
    buttonText: buttonText,
    backgroundColor: null,
    textColor: AppColors.primary100,
  );
}

class ButtonCTANotFilledDisabled extends ButtonCTA {
  const ButtonCTANotFilledDisabled({
    super.key,
    required String buttonText,
  }) : super(
    onPressed: null,
    buttonText: buttonText,
    backgroundColor: null,
    textColor: AppColors.neutralGrey50,
  );
}
