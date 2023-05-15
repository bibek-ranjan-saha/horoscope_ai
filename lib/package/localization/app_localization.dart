import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class AppLocalization {
  static const Locale english = Locale("en", "US");
  static const Locale hindi = Locale("hi", "IN");

  static void changeLocale(BuildContext context) {
    final currentLocale = context.locale;
    var newLocale = AppLocalization.english;
    if (currentLocale == AppLocalization.english) {
      newLocale = AppLocalization.hindi;
    }
    context.setLocale(newLocale);
  }
}
