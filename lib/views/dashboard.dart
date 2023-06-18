import 'package:aplicaciones_multiplataforma/design_system/celulas/header.dart';
import 'package:aplicaciones_multiplataforma/views/mi_perfil.dart';
import 'package:aplicaciones_multiplataforma/views/novedades.dart';
import 'package:aplicaciones_multiplataforma/views/postularse.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
    this.initialTab = 0
  });

  final int initialTab;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: widget.initialTab);
  }

  @override
  void didUpdateWidget(covariant Dashboard oldWidget) {
    _tabController.index = widget.initialTab;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: Header.appbar(_tabController, context),
        body: TabBarView(
          clipBehavior: Clip.none,
          controller: _tabController,
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
