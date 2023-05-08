import 'package:aplicaciones_multiplataforma/design_system/atoms/icons.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/typography.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/colors.dart';
import 'package:flutter/material.dart';

import 'design_system/molecules/buscador.dart';

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
            Buscador(focusNode: _focusNode, searchFocused: _searchFocused,),
            const SizedBox(height: 32),
            Column(
              children: [
                postularseCard(),
                postularseCard()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget postularseCard() {
    return Card(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => {
                Navigator.of(context).pushNamed('/card-seleccionada/')
              },
              child: SizedBox(
                height: 138,
                width: double.infinity,
                child: FittedBox(
                  clipBehavior: Clip.hardEdge,
                  fit: BoxFit.fitWidth,
                  child: Image.asset(
                    "assets/images/1109 techo 500.jpeg",
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 18, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ACCION SOCIAL',
                    style: MyTheme.overline(color: AppColors.neutralGrey75),
                  ),
                  Row(
                    children: [
                      Text(
                        'Manos caritativas',
                        style: MyTheme.subtitle01(),
                      ),
                      Expanded(child: Container(),),
                      MyIcons.favoriteOutlineActivated,
                      const SizedBox(width: 16,),
                      MyIcons.locationOnActivated,
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}


