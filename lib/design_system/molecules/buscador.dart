import 'package:aplicaciones_multiplataforma/design_system/tokens/shadows.dart';
import 'package:flutter/material.dart';

import '../atoms/icons.dart';
import '../tokens/typography.dart';

class Buscador extends StatefulWidget {

  final TextEditingController controller;
  final void Function() onEnterPressed;
  final void Function() onClearPressed;

  const Buscador({
    super.key,
    required this.controller,
    required this.onEnterPressed,
    required this.onClearPressed,
  });

  @override
  State<Buscador> createState() => _BuscadorState();
}

class _BuscadorState extends State<Buscador> {

  bool _showPrefixIcon = true;
  bool _showSuffixIcon = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      child: Center(
        child: Container(
          padding: EdgeInsets.only(left: widget.controller.text.isNotEmpty ? 16 : 0),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: AppShadows.sombra1,
          ),
          child: TextFormField(
            onEditingComplete: widget.onEnterPressed,
            controller: widget.controller,
            onChanged: _onChanged,
            keyboardType: TextInputType.text,
            style: MyTheme.subtitle01(),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: _showPrefixIcon ? MyIcons.searchEnabled : null,
              hintText: 'Buscar',
              suffixIcon: !_showSuffixIcon ? null
                  :
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.onClearPressed();
                        widget.controller.clear();
                        _showPrefixIcon = true;
                        _showSuffixIcon = false;
                      });
                    },
                    child: MyIcons.closeEnabled,
                  ),
            )
          ),
        ),
      ),
    );
  }

  void _onChanged(String value) {
    if(value.isNotEmpty) {
      setState(() {
        _showPrefixIcon = false;
        _showSuffixIcon = true;
      });
    } else {
      setState(() {
        _showPrefixIcon = true;
        _showSuffixIcon = false;
      });
    }
  }
}