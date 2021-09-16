import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_budget/models/transaction.dart';

enum WalletType {
  cash,
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

class Wallet {
  String id;
  String name;
  double amount;
  WalletType type;
  //TODO transactions
  List<Transaction> transactions;
  //plus options

  Wallet(
      {@required this.id,
      @required this.name,
      @required this.amount,
      @required this.type,
      //@required
      this.transactions});
}
