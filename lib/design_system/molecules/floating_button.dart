import 'package:aplicaciones_multiplataforma/design_system/atoms/icons.dart';
import 'package:flutter/material.dart';

import '../tokens/colors.dart';
import '../tokens/shadows.dart';

class FloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool activated;

  const FloatingButton({
    super.key,
    required this.onPressed,
    required this.activated,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4), //todo: falta ver bien como poner el radio del Figma
      child: TextButton(
          onPressed: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: activated ? AppColors.primary10 : AppColors.neutralGrey10,
              boxShadow: AppShadows.sombra3,
            ),
            width: 48,
            height: 48,
            child: activated ? MyIcons.nearMeActivated : MyIcons.nearMeDisabled,
          )
      ),
    );
  }
}

class FloatingButtonActivated extends FloatingButton {
  const FloatingButtonActivated({
    super.key,
    required VoidCallback onPressed,
  }) : super(
      onPressed: onPressed,
      activated: true
  );
}

class FloatingButtonDisabled extends FloatingButton {
  const FloatingButtonDisabled({
    super.key,
    required VoidCallback onPressed,
  }) : super(
      onPressed: onPressed,
      activated: false
  );
}