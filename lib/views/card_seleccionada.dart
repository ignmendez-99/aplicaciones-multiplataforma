import 'package:aplicaciones_multiplataforma/design_system/molecules/boton_cta.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/shadows.dart';
import 'package:aplicaciones_multiplataforma/models/voluntariado.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../design_system/celulas/modal.dart';
import '../design_system/tokens/colors.dart';
import '../design_system/tokens/typography.dart';

class CardSeleccionada extends StatefulWidget {

  final Future<Voluntariado?> voluntariado;

  const CardSeleccionada({
    super.key,
    required this.voluntariado
  });

  @override
  State<CardSeleccionada> createState() => _CardSeleccionadaState();
}

class _CardSeleccionadaState extends State<CardSeleccionada> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: widget.voluntariado,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasData && snapshot.data != null) {
              final voluntariado = snapshot.data!;
              return Column(
                children: [
                  SizedBox(
                    height: 243,
                    width: double.infinity,
                    child: Image.asset(
                      "assets/images/1109 techo 500.jpeg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          voluntariado.titulo,
                          textAlign: TextAlign.left,
                          style: MyTheme.headline01(),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'A dos horas al sur de Vicente López en la ciudad de Buenos Aires.',
                          style: MyTheme.body01(color: AppColors.neutralGrey75),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Container(
                  //   margin: const EdgeInsets.fromLTRB(16, 0, 16, 56),
                  //   child: ButtonCTAFilled(
                  //     buttonText: 'Postularme',
                  //     onPressed: () => showDialog(
                  //       context: context,
                  //       builder: (context) => const Modal(),
                  //     ),
                  //     disabled: false,
                  //   ),
                  // ),
                ],
              );
            } else {
              // TODO se supone que al llegar aca porque no hay voluntariado, se va a activar el redirect del router
              return Container();
            }
          }
      ) ,
    );
  }

}
