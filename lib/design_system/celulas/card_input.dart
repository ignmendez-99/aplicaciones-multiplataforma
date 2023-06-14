import 'package:flutter/material.dart';

import '../atoms/icons.dart';
import '../tokens/colors.dart';
import '../tokens/typography.dart';

class CardInput extends StatelessWidget {
  const CardInput({Key? key}) : super(key: key);

  static const List<String> generos = ['Hombre', 'Mujer', 'No binario'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
          color: AppColors.secondaryBlue25,
          child: Row(
            children: [
              Text(
                'Información de perfil',
                style: MyTheme.subtitle01(),
              ),
              // const Spacer()
            ],
          ),
        ),
        Container(
          color: AppColors.neutralGrey10,
          margin: const EdgeInsets.fromLTRB(16, 8, 0, 8),
          child: Column(
            children: List.generate(
              generos.length,
              (index) => Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(4, 4, 0, 4),
                    child: MyIcons.radioButtonUncheckedActivated
                  ),
                  const SizedBox(width: 8,),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 6, 4, 6),
                    child: Text(
                      generos[index],
                      style: MyTheme.body01(),
                    ),
                  ),
                ],
              ),
            ),
          )
        )
      ],
    );
  }
}
