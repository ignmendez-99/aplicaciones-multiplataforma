

import 'package:aplicaciones_multiplataforma/MiPerfil.dart';
import 'package:aplicaciones_multiplataforma/Novedades.dart';
import 'package:aplicaciones_multiplataforma/Postularse.dart';
import 'package:aplicaciones_multiplataforma/constants/themes.dart';
import 'package:flutter/material.dart';

import 'constants/colors.dart';

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
            width: 147,
            height: 25,
            margin: const EdgeInsets.fromLTRB(16, 8, 0, 8),
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fill,
            ),
          ),
          leadingWidth: 147, // default is 56
          bottom: const TabBar(
            unselectedLabelStyle: MyTheme.buttonNeutralGrey25,
            labelStyle: const TextStyle(fontSize: 14),
            labelColor: const Color(0xFFFFFFFF),
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            indicator: const BoxDecoration(
              color: AppColors.secondaryBlue200,
            ),
            tabs: [
              Tab(
                child: Center(
                  child: const Text(
                    'Postularse',
                  ),
                ),
              ),
              const Tab(
                child: Center(
                  child: Text(
                    'Mi perfil',
                  ),
                ),
              ),
              const Tab(
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
