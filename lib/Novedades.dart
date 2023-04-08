import 'package:aplicaciones_multiplataforma/constants/themes.dart';
import 'package:flutter/material.dart';

class Novedades extends StatefulWidget {
  const Novedades({Key? key}) : super(key: key);

  @override
  State<Novedades> createState() => _NovedadesState();
}

class _NovedadesState extends State<Novedades> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 32, 16, 32),
        child: Column(
          children: [
            novedadesCard(),
            novedadesCard(),
            novedadesCard(),
            novedadesCard(),
            novedadesCard(),
          ],
        ),
      ),
    );
  }

  Widget novedadesCard() {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 156,
            width: 118,
            child: FittedBox(
              clipBehavior: Clip.hardEdge,
              fit: BoxFit.fitHeight,
              child: Image.asset(
                "assets/images/novedades_1.jpeg",
              ),
            ),
          ),
          Container(
            width: 194,
            margin: const EdgeInsets.fromLTRB(8, 16, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'REPORTE 2820',
                  style: MyTheme.overlineNeutralGrey75,
                ),
                const Text(
                  'Ser donante voluntario',
                  style: MyTheme.subtitle01,
                ),
                const Text(
                  'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
                  style: MyTheme.body02NeutralGrey75,
                ),
                const SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: (){},
                      child: const Text(
                        'Leer mas',
                        style: MyTheme.buttonPrimary,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
