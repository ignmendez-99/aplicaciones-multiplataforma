import 'package:flutter/material.dart';

import '../atoms/icons.dart';
import '../tokens/colors.dart';
import '../tokens/typography.dart';

class CardVoluntariado extends StatelessWidget {
  const CardVoluntariado({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => {
              Navigator.of(context).pushNamed('/card-seleccionada/')
            },
            child: SizedBox(
              height: 138,
              width: double.infinity,
              child: FittedBox(
                clipBehavior: Clip.hardEdge,
                fit: BoxFit.fitWidth,
                child: Image.asset(
                  "assets/images/1109 techo 500.jpeg",
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 18, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ACCION SOCIAL',
                  style: MyTheme.overline(color: AppColors.neutralGrey75),
                ),
                Row(
                  children: [
                    Text(
                      'Manos caritativas',
                      style: MyTheme.subtitle01(),
                    ),
                    const Spacer(),
                    MyIcons.favoriteOutlineActivated,
                    const SizedBox(width: 16,),
                    MyIcons.locationOnActivated,
                  ],
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
