import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:my_budget/hive_helper/fields/trx_category_fields.dart';
import 'package:my_budget/hive_helper/hive_adapters.dart';
import 'package:my_budget/hive_helper/hive_types.dart';

part 'transaction_category.g.dart';

@HiveType(typeId: HiveTypes.trxCategory, adapterName: HiveAdapters.trxCategory)
class TrxCategory extends HiveObject {
  @HiveField(TrxCategoryFields.id)
  String id;
  @HiveField(TrxCategoryFields.name)
  String name;
  @HiveField(TrxCategoryFields.color)
  int colorCode;

  TrxCategory({@required this.name, @required this.colorCode}) {
    this.id = "trxCategory-" + Uuid().v1();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TrxCategory && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ colorCode.hashCode;

  @override
  String toString() =>
      'TrxCategory(id: $id, name: $name, colorCode: $colorCode)';

  Color getColor() {
    return MaterialColor(this.colorCode, null);
  }
}
