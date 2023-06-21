import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../atoms/icons.dart';
import '../tokens/colors.dart';
import '../tokens/shadows.dart';
import '../tokens/typography.dart';

class CardVoluntariadoActual extends StatelessWidget {
  const CardVoluntariadoActual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.primary5,
          border: Border.all(
            color: AppColors.primary100,
            width: 2
          ),
          boxShadow: AppShadows.sombra2,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.socialAction.toUpperCase(),
                  style: MyTheme.overline(color: AppColors.neutralGrey75),
                ),
                Text(
                  AppLocalizations.of(context)!.roofForCountry,
                  style: MyTheme.subtitle01(),
                ),
              ],
            ),
            const Spacer(),
            MyIcons.locationOnActivated,
          ],
        ),
      )
    );
  }
}
