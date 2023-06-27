import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SerManosDateUtils {
  static DateFormat dateFormatter(BuildContext context) {
    return DateFormat(AppLocalizations.of(context)!.exactDateFormat);
  }
}