import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../tokens/colors.dart';

class SerManosStatusBarWidget extends StatelessWidget {
  final Color statusBarColor;
  final Widget child;

  const SerManosStatusBarWidget({
    super.key,
    required this.statusBarColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // Specify the desired changes to the theme
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: statusBarColor,
          ),
          iconTheme: const IconThemeData(
            color: AppColors.neutralGrey75,
          ),
        ),
      ),
      child: child
    );
  }
}