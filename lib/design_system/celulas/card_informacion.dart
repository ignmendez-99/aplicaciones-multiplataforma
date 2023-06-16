import 'package:flutter/material.dart';

import '../tokens/colors.dart';
import '../tokens/typography.dart';

class CardInformacion extends StatelessWidget {
  const CardInformacion({Key? key}) : super(key: key);

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
                'Titulo',
                style: MyTheme.subtitle01(),
              ),
              // const Spacer()
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: AppColors.neutralGrey10,
          margin: const EdgeInsets.fromLTRB(16, 8, 0, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LABEL',
                style: MyTheme.overline(color: AppColors.neutralGrey75),
              ),
              Text(
                'Content',
                style: MyTheme.body01(color: AppColors.neutralGrey75),
              ),
              const SizedBox(height: 8,),
              Text(
                'LABEL',
                style: MyTheme.overline(color: AppColors.neutralGrey75),
              ),
              Text(
                'Content',
                style: MyTheme.body01(color: AppColors.neutralGrey75),
              ),
            ]
          )
        )
      ],
    );
  }
}
