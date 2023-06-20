import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:flutter/material.dart';

import '../tokens/shadows.dart';

class Modal extends StatelessWidget {
  const Modal({
    super.key,
    required this.modalBody,
    required this.buttonOneText,
    required this.buttonTwoText,
    required this.onPressedButtonOne,
    required this.onPressedButtonTwo,
  });

  final Widget modalBody;
  final String buttonOneText;
  final String buttonTwoText;
  final void Function() onPressedButtonOne;
  final void Function() onPressedButtonTwo;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: AppShadows.sombra3,
        ),
        width: 280,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            modalBody,
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonCTANotFilled(
                  buttonText: buttonOneText,
                  onPressed: onPressedButtonOne,
                  disabled: false,
                ),
                const SizedBox(height: 8,),
                ButtonCTANotFilled(
                  buttonText: buttonTwoText,
                  onPressed: onPressedButtonTwo,
                  disabled: false,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
