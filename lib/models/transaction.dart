import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_budget/hive_helper/hive_types.dart';
import 'package:my_budget/hive_helper/hive_adapters.dart';
import 'package:my_budget/hive_helper/fields/transaction_fields.dart';
import 'package:uuid/uuid.dart';

part 'transaction.g.dart';

@HiveType(typeId: HiveTypes.transaction, adapterName: HiveAdapters.transaction)
class Transaction extends HiveObject {
  @HiveField(TransactionFields.id)
  String id;
  @HiveField(TransactionFields.category)
  String categoryId;
  @HiveField(TransactionFields.isIncome)
  bool isIncome;
  @HiveField(TransactionFields.date)
  DateTime date;
  @HiveField(TransactionFields.amount)
  double amount;
  @HiveField(TransactionFields.desc)
  String desc;
  @HiveField(TransactionFields.wallet)
  String walletId;
  // photos

  Transaction(
      {@required this.categoryId,
      @required this.isIncome,
      @required this.date,
      @required this.amount,
      @required this.desc,
      @required this.walletId}) {
    this.id = "trx-" + Uuid().v1();
  }

  Transaction.copy({@required Transaction trx, @required DateTime date}) {
    this.id = "trx-" + Uuid().v1();
    this.categoryId = trx.categoryId;
    this.isIncome = trx.isIncome;
    this.date = date;
    this.amount = trx.amount;
    this.desc = trx.desc;
    this.walletId = trx.walletId;
  }

  @override
  String toString() {
    return 'Transaction(id: $id, categoryId: $categoryId, isIncome: $isIncome, date: $date, amount: $amount, desc: $desc, walletId: $walletId)';
  }
}
