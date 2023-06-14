import 'package:aplicaciones_multiplataforma/design_system/atoms/icons.dart';
import 'package:flutter/material.dart';

import '../tokens/colors.dart';
import '../tokens/typography.dart';

class Vacantes extends StatelessWidget {
  final int vacantes;

  const Vacantes({
    super.key,
    required this.vacantes
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: vacantes == 0 ? AppColors.neutralGrey25 : AppColors.secondaryBlue25,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(8, 6, 0, 6),
            child: Text(
              'Vacantes:',
              style: MyTheme.body02(),
            )
          ),
          const SizedBox(width: 8,),
          vacantes == 0 ? MyIcons.personDisabled : MyIcons.personActivated,
          Container(
            margin: const EdgeInsets.fromLTRB(0, 4, 8, 6),
            child: Text(
              vacantes.toString(),
              style: MyTheme.subtitle01(
                color: vacantes == 0 ? AppColors.secondaryBlue80 : AppColors.secondaryBlue200,
              ),
            )
          )
        ],
      ),
    );
  }
}
