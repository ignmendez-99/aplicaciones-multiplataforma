

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
            bottom: const TabBar(
              tabs: [
                Tab(text: 'FIRST'),
                Tab(text: 'SECOND',),
                Tab(text: 'THIRD'),
              ],
            ),
            title: const Text('TABS TITLE TEXT'),
          ),
          body: TabBarView(
            children: [
              const Postularse(),
              const Novedades(),
              const MiPerfil()
            ],
          ),
        ),
      ),
    );
  }
}
