import 'package:flutter/material.dart';

class TrxCategory {
  String id;
  String name;
  MaterialColor color;
  //TODO Color example: charts.MaterialPalette.red.makeShades(5)[4]

  TrxCategory({@required this.id, @required this.name, this.color});
}
