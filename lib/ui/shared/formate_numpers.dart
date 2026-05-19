import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

String formatNumber(num number) {
  return NumberFormat.decimalPattern(Intl.getCurrentLocale()).format(number);
}
