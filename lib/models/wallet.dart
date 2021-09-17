import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_budget/hive_helper/hive_types.dart';
import 'package:my_budget/hive_helper/hive_adapters.dart';
import 'package:my_budget/hive_helper/fields/wallet_fields.dart';
import 'package:my_budget/models/transaction.dart';
import 'package:my_budget/models/wallet_type.dart';
import 'package:uuid/uuid.dart';

part 'wallet.g.dart';

@HiveType(typeId: HiveTypes.wallet, adapterName: HiveAdapters.wallet)
class Wallet extends HiveObject {
  @HiveField(WalletFields.id)
  String id;
  @HiveField(WalletFields.name)
  String name;
  @HiveField(WalletFields.amount)
  double amount;
  @HiveField(WalletFields.type)
  WalletType type;
  //TODO transactions
  @HiveField(WalletFields.transactions)
  List<Transaction> transactions;
  //plus options

  Wallet(
      {@required this.name,
      @required this.amount,
      @required this.type,
      //@required
      this.transactions}) {
    this.id = "wallet-" + Uuid().v1();
  }

  String toString() {
    return 'Wallet(id: $id, name: $name, amount: $amount, transactions: $transactions)';
  }
}
