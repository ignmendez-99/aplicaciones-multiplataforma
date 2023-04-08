import 'package:aplicaciones_multiplataforma/constants/colors.dart';
import 'package:aplicaciones_multiplataforma/constants/themes.dart';
import 'package:flutter/material.dart';

class ShortButtonWithIcon extends StatelessWidget {
  final Icon icon;
  final String buttonText;
  final VoidCallback onPressed;

  const ShortButtonWithIcon({Key? key, required this.icon, required this.buttonText, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4), //todo: falta ver bien como poner el radio del Figma
      child: TextButton(
          onPressed: onPressed,
          child: Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            color: AppColors.primary,
            width: 123,
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 8,),
                Text(buttonText, style: MyTheme.buttonNeutralWhite,)
              ],
            ),
          )
      ),
    );
  }
}
