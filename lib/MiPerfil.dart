import 'package:flutter/material.dart';

class MiPerfil extends StatefulWidget {
  const MiPerfil({Key? key}) : super(key: key);

  @override
  State<MiPerfil> createState() => _MiPerfilState();
}

class _MiPerfilState extends State<MiPerfil> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 147),
        SizedBox(
          width: 120,
          height: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(90),
            child: Image.asset(
              "assets/images/face.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: const [
              Text(
                'VOLUNTARIO',
              ),
              SizedBox(height: 8),
              Text(
                'juan cruz',
              ),
              SizedBox(height: 8),
              Text(
                '¡Completá tu perfil para tener \nacceso a mejores oportunidades!',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        const Spacer(),
        Container(
          margin: const EdgeInsets.only(bottom: 80),
          child: TextButton(
              onPressed: (){},
              child: const Text('+ Completar')
          ),
        )
      ],
    );
  }
}
