import 'package:aplicaciones_multiplataforma/design_system/celulas/card_voluntariado.dart';
import 'package:flutter/material.dart';

import '../design_system/molecules/buscador.dart';


class Postularse extends StatefulWidget {
  const Postularse({Key? key}) : super(key: key);

  @override
  State<Postularse> createState() => _PostularseState();
}

class _PostularseState extends State<Postularse> {

  final myController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _searchFocused = false;

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
  }

  void _printLatestValue() {
    print('Second text field: ${myController.text}');
  }

  @override
  void initState() {
    myController.addListener(_printLatestValue);
    _focusNode.addListener(_onFocusChange);
    super.initState();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus != _searchFocused) {
      setState(() {
        _searchFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 24, 16, 0),
        child: Column(
          children: [
            const Buscador(),
            const SizedBox(height: 32),
            Column(
              children: const [
                CardVoluntariado(),
                CardVoluntariado(),
                CardVoluntariado(),
              ],
            )
          ],
        ),
      ),
    );
  }

}


