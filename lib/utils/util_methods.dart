import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getFormattedCurrency({BuildContext context, double value}) {
  Locale locale = Localizations.localeOf(context);
  var format = NumberFormat.simpleCurrency(locale: locale.toString());
  // print(format.format(double.parse(value)));
  print("CURRENCY SYMBOL ${format.currencySymbol}");
  print("CURRENCY NAME ${format.currencyName}");

  return format.format(value);
}
