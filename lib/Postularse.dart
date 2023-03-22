import 'package:flutter/material.dart';

class Postularse extends StatefulWidget {
  const Postularse({Key? key}) : super(key: key);

  @override
  State<Postularse> createState() => _PostularseState();
}

class _PostularseState extends State<Postularse> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Buscador(),
    );
  }
}

class Buscador extends StatefulWidget {
  const Buscador({Key? key}) : super(key: key);

  @override
  State<Buscador> createState() => _BuscadorState();
}

class _BuscadorState extends State<Buscador> {

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('Second text field: ${myController.text}');
  }

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Expanded(
            child: Container(
              color: Colors.greenAccent,
              margin: const EdgeInsets.fromLTRB(16, 12, 0, 12),
              child: TextField(),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(3.25, 15.26, 19.26, 15.25),
            padding: const EdgeInsets.fromLTRB(3.26, 3.25, 3.25, 3.26),
            color: Colors.green,
            child: const Icon(
              Icons.search,
              color: Colors.pink,
              size: 24,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
          ),
        ],
      ),
    );
  }
}
