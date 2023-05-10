import 'package:aplicaciones_multiplataforma/design_system/celulas/card_novedades.dart';
import 'package:flutter/material.dart';

class Novedades extends StatelessWidget {
  const Novedades({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: Column(
          children: const [
            CardNovedades(),
            CardNovedades(),
            CardNovedades(),
            CardNovedades(),
            CardNovedades(),
          ],
        ),
      ),
    );
  }
}
