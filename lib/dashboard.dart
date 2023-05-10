import 'package:aplicaciones_multiplataforma/design_system/celulas/header.dart';
import 'package:aplicaciones_multiplataforma/mi_perfil.dart';
import 'package:aplicaciones_multiplataforma/novedades.dart';
import 'package:aplicaciones_multiplataforma/postularse.dart';
import 'package:flutter/material.dart';

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
        appBar: Header.appbar,
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
