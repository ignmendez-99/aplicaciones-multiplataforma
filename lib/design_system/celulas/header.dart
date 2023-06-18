import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          context.goNamed('dashboard', pathParameters: {'tabId': index.toString()})
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
        tabs: const [
          AppTab(tabText: 'Postularse'),
          AppTab(tabText: 'Mi perfil'),
          AppTab(tabText: 'Novedades'),
        ],
      ),
    );
  }

}
