import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:my_budget/hive_helper/fields/wallet_fields.dart';
import 'package:my_budget/hive_helper/hive_adapters.dart';
import 'package:my_budget/hive_helper/hive_types.dart';
import 'package:my_budget/models/transaction.dart';
import 'package:my_budget/models/wallet_type.dart';

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
  List<String> transactionsId;
  //plus options

  Wallet(
      {@required this.name,
      @required this.amount,
      @required this.type,
      @required this.transactionsId}) {
    this.id = "wallet-" + Uuid().v1();
  }

  Wallet.fromId({
    @required String id,
  }) {
    this.id = id;
    this.amount = 0;
    this.name = "Deleted";
    this.type = WalletType.card;
    this.transactionsId = [];
  }

  String toString() {
    return 'Wallet(id: $id, name: $name, amount: $amount, transactionsId: $transactionsId , type: ${type.name})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Wallet && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
