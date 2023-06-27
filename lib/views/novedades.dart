import 'package:aplicaciones_multiplataforma/design_system/celulas/card_novedades.dart';
import 'package:aplicaciones_multiplataforma/services/novedad_service.dart';
import 'package:flutter/material.dart';

import '../models/novedad.dart';

class Novedades extends StatefulWidget {
  const Novedades({Key? key}) : super(key: key);

  @override
  State<Novedades> createState() => _NovedadesState();
}

class _NovedadesState extends State<Novedades> {

  final NovedadService _novedadService = NovedadService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: FutureBuilder(
          future: _novedadService.getAllNovedades(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasData && snapshot.data != null) {
              final List<Novedad> novedades = snapshot.data!;
              return Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: novedades.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 24),
                    itemBuilder: (context, index) {
                      return CardNovedades(novedad: novedades[index]);
                    },
                  ),
                ]
              );
            } else {
              return Container();
            }
          }
        ),
      ),
    );
  }
}
