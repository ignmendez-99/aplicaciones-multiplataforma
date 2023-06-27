import 'package:flutter/material.dart';

import '../tokens/colors.dart';
import '../tokens/typography.dart';

class CardInformacion extends StatelessWidget {

  const CardInformacion({
    super.key,
    required this.titulo,
    required this.label1,
    required this.content1,
    required this.label2,
    required this.content2,
  });

  final String titulo;
  final String label1;
  final String content1;
  final String label2;
  final String content2;

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
                titulo,
                style: MyTheme.subtitle01(),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: AppColors.neutralGrey10,
          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label1,
                style: MyTheme.overline(color: AppColors.neutralGrey75),
              ),
              Text(
                content1,
                style: MyTheme.body01(color: AppColors.neutralGrey75),
              ),
              const SizedBox(height: 8,),
              Text(
                label2,
                style: MyTheme.overline(color: AppColors.neutralGrey75),
              ),
              Text(
                content2,
                style: MyTheme.body01(color: AppColors.neutralGrey75),
              ),
            ]
          )
        )
      ],
    );
  }
}
