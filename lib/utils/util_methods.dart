import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getFormattedCurrency({BuildContext context, double value}) {
  Locale locale = Localizations.localeOf(context);
  var format = NumberFormat.simpleCurrency(locale: locale.toString());
  // print(format.format(double.parse(value)));
  // print("CURRENCY SYMBOL ${format.currencySymbol}");
  // print("CURRENCY NAME ${format.currencyName}");

  return format.format(value);
}

String getFormatedMMddDate(DateTime date) {
  final DateFormat formatter = DateFormat('MM.dd.');
  return formatter.format(date);
}

String getFormatedyyyyMMMMDate(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy.MMMM');
  var schema = formatter.format(date);
  return formatter.format(date).replaceRange(5, 6, schema[5].toUpperCase());
}

String getFormatedyyyyMMMDate(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy.MMM');
  var schema = formatter.format(date);
  return formatter.format(date).replaceRange(5, 6, schema[5].toUpperCase());
}
