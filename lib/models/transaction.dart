import 'package:flutter/cupertino.dart';
import 'package:my_budget/models/wallet.dart';

class Transaction {
  String id;
  String name;
  TrxCategory category;
  bool isIncome;
  DateTime date;
  double amount;
  String desc;
  Wallet wallet;
  // photos

  Transaction(
      {@required this.id,
      @required this.name,
      @required this.category,
      @required this.isIncome,
      @required this.date,
      @required this.amount,
      @required this.desc,
      @required this.wallet});
}

class TrxCategory {
  String name;

  TrxCategory({@required this.name});
}
