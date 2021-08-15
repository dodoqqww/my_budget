import 'package:flutter/cupertino.dart';
import 'package:my_budget/models/wallet.dart';

class Transaction {
  final String id;
  final String name;
  final DateTime date;
  final double amount;
  final String desc;
  final Wallet wallet;
  // photos

  Transaction(
      {@required this.id,
      @required this.name,
      @required this.date,
      @required this.amount,
      @required this.desc,
      @required this.wallet});
}
