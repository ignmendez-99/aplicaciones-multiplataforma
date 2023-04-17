import 'package:aplicaciones_multiplataforma/design_system/tokens/colors.dart';
import 'package:flutter/material.dart';

import '../atoms/icons.dart';
import '../tokens/typography.dart';

class Buscador extends StatelessWidget {

  final FocusNode focusNode;
  final bool searchFocused;

  const Buscador({required this.focusNode, required this.searchFocused});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 328,
        height: 48,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 12, 0, 12),
                child: TextField(
                  style: MyTheme.subtitle01(),
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: "Buscar",  // TODO: cuando se pone esta linea, el texto se va para arriba
                    hintStyle: searchFocused ? MyTheme.subtitle01(color: AppColors.neutralGrey50) : MyTheme.subtitle01(color: AppColors.neutralGrey75),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 12, 16, 12),
              child: MyIcons.searchEnabled,
            ),
          ],
        ),
      ),
    );
  }
}