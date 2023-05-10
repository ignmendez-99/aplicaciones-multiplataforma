import 'package:aplicaciones_multiplataforma/design_system/tokens/colors.dart';
import 'package:aplicaciones_multiplataforma/design_system/tokens/shadows.dart';
import 'package:flutter/material.dart';

import '../atoms/icons.dart';
import '../tokens/typography.dart';

class Buscador extends StatefulWidget {

  const Buscador({super.key});

  @override
  State<Buscador> createState() => _BuscadorState();
}

class _BuscadorState extends State<Buscador> {
  bool _typing = false;
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: AppShadows.sombra1,
        ),
        padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        child: TextFormField(
          style: MyTheme.subtitle01(),
          focusNode: _focusNode,
          decoration: InputDecoration(
            suffixIcon: getSuffixIcon(),
            hintText: "Buscar",
            hintStyle: _focusNode.hasFocus ? MyTheme.subtitle01(color: AppColors.neutralGrey50) : MyTheme.subtitle01(color: AppColors.neutralGrey75),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget? getSuffixIcon() {
    if(_typing) {
      return MyIcons.closeEnabled;
    }
    return MyIcons.searchEnabled;
  }
}