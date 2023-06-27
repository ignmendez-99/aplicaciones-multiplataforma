import 'dart:ui';

import 'package:intl/intl.dart';

class CurrencyUtils {
  static NumberFormat currencyFormatter() {
    Locale userLocale = window.locale;
    return NumberFormat.currency(locale: userLocale.languageCode, symbol: '\$');
  }
}