import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension NumberLocalization on num {
  String toLocalizedString(BuildContext context) {
    final formatted = this % 1 == 0 ? toInt().toString() : toStringAsFixed(1);

    if (context.locale == const Locale('ar')) {
      return formatted
          .replaceAll('0', '٠')
          .replaceAll('1', '١')
          .replaceAll('2', '٢')
          .replaceAll('3', '٣')
          .replaceAll('4', '٤')
          .replaceAll('5', '٥')
          .replaceAll('6', '٦')
          .replaceAll('7', '٧')
          .replaceAll('8', '٨')
          .replaceAll('9', '٩');
    }
    return formatted;
  }
}
