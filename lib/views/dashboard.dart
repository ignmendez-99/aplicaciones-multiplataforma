import 'package:aplicaciones_multiplataforma/design_system/celulas/header.dart';
import 'package:aplicaciones_multiplataforma/views/mi_perfil.dart';
import 'package:aplicaciones_multiplataforma/views/novedades.dart';
import 'package:aplicaciones_multiplataforma/views/postularse.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: Header.appbar,
        body: TabBarView(
          children: [
            const Postularse(),
            MiPerfil(),
            const Novedades(),
          ],
        ),
      ),
    );
  }
}
