import 'package:flutter/material.dart';

class TrxCategory {
  String id;
  String name;
  MaterialColor color;

  TrxCategory({@required this.id, @required this.name, @required this.color});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TrxCategory && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ color.hashCode;
}
