import 'package:aplicaciones_multiplataforma/design_system/atoms/logo_rectangular.dart';
import 'package:aplicaciones_multiplataforma/mi_perfil.dart';
import 'package:aplicaciones_multiplataforma/novedades.dart';
import 'package:aplicaciones_multiplataforma/postularse.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/typography.dart';
import 'package:flutter/material.dart';

import 'design_system/tokens/colors.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 41,
          leading: Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 0, 8),
            child: LogoRectangular()
          ),
          leadingWidth: LogoRectangular.logoWidth, // default is 56
          bottom: TabBar(
            unselectedLabelStyle: MyTheme.button(color: AppColors.neutralGrey25),
            labelStyle: MyTheme.button(color: AppColors.neutralWhite),
            indicatorColor: Colors.white,
            // indicatorWeight: 3,
            // indicatorPadding: EdgeInsets.only(bottom: 3),
            indicator: const BoxDecoration(
              color: AppColors.secondaryBlue200,
            ),
            tabs: const [
              Tab(
                child: Center(
                  child: Text(
                    'Postularse',
                  ),
                ),
              ),
              Tab(
                child: Center(
                  child: Text(
                    'Mi perfil',
                  ),
                ),
              ),
              Tab(
                child: Center(
                  child: Text(
                    'Novedades',
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Postularse(),
            MiPerfil(),
            Novedades(),
          ],
        ),
      ),
    );
  }
}
