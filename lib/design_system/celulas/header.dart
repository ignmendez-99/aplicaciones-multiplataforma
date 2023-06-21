import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../atoms/logo_rectangular.dart';
import '../molecules/tab.dart';
import '../tokens/colors.dart';
import '../tokens/typography.dart';

class Header {

  static appbar(controller, BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondaryBlue90,
      toolbarHeight: 41,
      leading: Container(
          margin: const EdgeInsets.fromLTRB(16, 8, 0, 8),
          child: const LogoRectangular()
      ),
      leadingWidth: LogoRectangular.logoWidth,
      // default is 56
      // TODO el color de las tabs no seleccionadas, y el color del status bar, deben ser diferentes
      bottom: TabBar(
        controller: controller,
        onTap: (index) => {
          if(index == 0) {
            context.goNamed('voluntariados')
          } else if(index == 1) {
            context.goNamed('miPerfil')
          } else if(index == 2) {
            context.goNamed('novedades')
          }
        },
        unselectedLabelStyle: MyTheme.button(color: AppColors.neutralGrey25),
        labelStyle: MyTheme.button(color: AppColors.neutralWhite),
        indicator: const BoxDecoration(
          color: AppColors.secondaryBlue200,
          border: Border(
              bottom: BorderSide(
                color: AppColors.neutralWhite,
                width: 3,
              )
          ),
        ),
        tabs: [
          AppTab(tabText: AppLocalizations.of(context)!.apply),
          AppTab(tabText: AppLocalizations.of(context)!.myProfile),
          AppTab(tabText: AppLocalizations.of(context)!.news),
        ],
      ),
    );
  }

}
