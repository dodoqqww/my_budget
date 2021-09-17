import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_budget/hive_helper/hive_adapters.dart';
import 'package:my_budget/hive_helper/hive_types.dart';

part 'wallet_type.g.dart';

@HiveType(typeId: HiveTypes.walletType, adapterName: HiveAdapters.walletType)
enum WalletType {
  @HiveField(0)
  cash,
  @HiveField(1)
  card,
}

extension WalletTypeExtension on WalletType {
  Icon get icon {
    switch (this) {
      case WalletType.card:
        return Icon(Icons.credit_card);
      case WalletType.cash:
        return Icon(Icons.paid_outlined);
      default:
        return null;
    }
  }

  String get name {
    switch (this) {
      case WalletType.card:
        return "Card";
      case WalletType.cash:
        return "Cash";
      default:
        return null;
    }
  }
}
