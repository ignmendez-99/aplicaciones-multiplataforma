import 'package:aplicaciones_multiplataforma/design_system/celulas/header.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/colors.dart';
import 'package:aplicaciones_multiplataforma/models/user.dart';
import 'package:aplicaciones_multiplataforma/views/mi_perfil.dart';
import 'package:aplicaciones_multiplataforma/views/novedades.dart';
import 'package:aplicaciones_multiplataforma/views/postularse.dart';
import 'package:flutter/material.dart';

import '../design_system/atoms/status_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
    this.initialTab = 0,
    required this.loggedUser,
  });

  final int initialTab;
  final Future<SerManosUser> loggedUser;

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
    return SerManosStatusBarWidget(
      statusBarColor: AppColors.secondaryBlue90,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: Header.appbar(_tabController, context),
          body: TabBarView(
            clipBehavior: Clip.none,
            controller: _tabController,
            children: [
              Postularse(loggedUser: widget.loggedUser),
              MiPerfil(loggedUser: widget.loggedUser),
              const Novedades(),
            ],
          ),
        ),
      ),
    );
  }
}
