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
        margin: const EdgeInsets.fromLTRB(16, 32, 16, 0),
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
        children: [
          SizedBox(
            height: 138,
            width: 118,
            child: FittedBox(
              clipBehavior: Clip.hardEdge,
              fit: BoxFit.fitHeight,
              child: Image.asset(
                "assets/images/novedades_1.jpeg",
              ),
            ),
          ),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('REPORTE 2820'),
                    Text('Ser donante voluntario'),
                    Text('Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (){},
                    child: const Text('Leer mas'),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
