

import 'package:aplicaciones_multiplataforma/MiPerfil.dart';
import 'package:aplicaciones_multiplataforma/Novedades.dart';
import 'package:aplicaciones_multiplataforma/Postularse.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            toolbarHeight: 41,
            leading: Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 0, 8),
              child: Image.asset(
                "assets/images/logo.png",
                // width: 147,
                // height: 25,
                fit: BoxFit.fill,
              ),
            ),
            leadingWidth: 147, // default is 56
            bottom: TabBar(
              unselectedLabelColor: const Color(0xE0E0E0FF),
              unselectedLabelStyle: const TextStyle(fontSize: 14),
              labelStyle: const TextStyle(fontSize: 14),
              labelColor: const Color(0xFFFFFFFF),
              indicatorColor: Colors.orange,
              indicatorWeight: 3,
              indicator: const BoxDecoration(
                color: Colors.red,
              ),
              tabs: [
                Tab(
                  child: Container(
                    color:Colors.black,
                    width: double.infinity,
                    height: double.infinity,
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
      ),
    );
  }
}
