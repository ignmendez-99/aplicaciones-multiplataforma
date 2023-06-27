import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/cupertino.dart';

class GenderUtils {
  static String getGenderTranslated({required String genderInSpanish, required BuildContext context}) {
    Locale userLocale = window.locale;
    if(userLocale.languageCode == 'en') {
      switch(genderInSpanish) {
        case 'No binario':
          return AppLocalizations.of(context)!.genderOther;
        case "Hombre":
          return AppLocalizations.of(context)!.genderMale;
        case "Mujer":
          return AppLocalizations.of(context)!.genderFemale;
      }
      throw Exception('Genero no soportado');
    } else {
      return genderInSpanish;
    }
  }
}