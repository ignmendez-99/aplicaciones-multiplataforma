import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../design_system/tokens/colors.dart';

class CustomSnackbar {

  static Future<void> showSnackbar({required BuildContext context, required String detail}) async {
    await Flushbar(
      title: AppLocalizations.of(context)!.error,
      message: detail,
      duration: const Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      backgroundColor: AppColors.error,
    ).show(context);
  }
}