import 'package:flutter/material.dart';

import '../tokens/colors.dart';

class ShortButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Widget content;
  final bool disabled;

  const ShortButton({
    super.key,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.content,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: TextButton(
        onPressed: onPressed,
        child: Container(
          color: disabled ? AppColors.neutralGrey25 : AppColors.primary100,
          width: width,
          height: height,
          child: Center(child: content),
        )
      ),
    );
  }
}

class ShortButtonDefault extends ShortButton {
  const ShortButtonDefault({
    super.key,
    required VoidCallback onPressed,
    required Widget content,
  }) : super(
    onPressed: onPressed,
    width: 123,
    height: 48,
    content: content,
    disabled: false,
  );
}

class ShortButtonChico extends ShortButton {
  const ShortButtonChico({
    super.key,
    required VoidCallback onPressed,
    required Widget content,
  }) : super(
    onPressed: onPressed,
    width: 123,
    height: 40,
    content: content,
    disabled: false,
  );
}