import 'package:aplicaciones_multiplataforma/constants/colors.dart';
import 'package:aplicaciones_multiplataforma/constants/themes.dart';
import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const LongButton({Key? key, required this.buttonText, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4), //todo: falta ver bien como poner el radio del Figma
      child: TextButton(
          onPressed: onPressed,
          child: Container(
            color: AppColors.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                  child: Text(
                    buttonText,
                    style: MyTheme.buttonNeutralWhite,
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
