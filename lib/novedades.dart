import 'package:aplicaciones_multiplataforma/design_system/tokens/typography.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/colors.dart';
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
            margin: const EdgeInsets.fromLTRB(8, 16, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'REPORTE 2820',
                  style: MyTheme.overline(color: AppColors.neutralGrey75),
                ),
                Text(
                  'Ser donante voluntario',
                  style: MyTheme.subtitle01(),
                ),
                Text(
                  'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
                  style: MyTheme.body02(color: AppColors.neutralGrey75),
                ),
                const SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: (){},
                      child: Text(
                        'Leer mas',
                        style: MyTheme.button(color: AppColors.primary),
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
