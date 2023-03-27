import 'package:flutter/material.dart';

class Novedades extends StatefulWidget {
  const Novedades({Key? key}) : super(key: key);

  @override
  State<Novedades> createState() => _NovedadesState();
}

class _NovedadesState extends State<Novedades> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        children: [
          const SizedBox(height: 147),
          Container(
            color: Colors.blue,
            width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Image.asset(
                "assets/images/face.png",
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
