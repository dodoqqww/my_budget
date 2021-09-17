//import 'package:math_expressions/math_expressions.dart';
//
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_budget/models/reminder.dart';
import 'package:my_budget/models/transaction.dart';
import 'package:my_budget/models/transaction_category.dart';
import 'package:my_budget/models/wallet.dart';
import 'package:my_budget/models/wallet_type.dart';

abstract class DatabaseManagerService {
  List<Wallet> getAllWallets();
  List<TrxCategory> getAllTrxCategorys();
  List<Reminder> getAllReminders();
  List<Transaction> getAllTransaction();
  void addTrx();
  void copyTrx();
  void deleteTrx();
  void updateTrx();
  void addWallet();
  Future<void> deleteWallet(Wallet wallet);
  void updateWallet();
  void addTrxCategory();
  void deleteTrxCategory();
  void updateTrxCategory();
  void addReminder();
  void deleteReminder();
  void updateReminder();
}

class HiveDatabaseManagerService extends DatabaseManagerService {
  @override
  void addTrxCategory() {
    print("addTrxCategory() from service");
  }

  @override
  void addWallet() {
    print("addWallet() from service");
  }

  @override
  void deleteTrxCategory() {
    print("deleteTrxCategory() from service");
  }

  @override
  Future<void> deleteWallet(Wallet wallet) async {
    print("deleteWallet() from service");
    var box = Hive.box<Wallet>('walletsBox');
    await box.delete(wallet.id);
  }

  @override
  List<TrxCategory> getAllTrxCategorys() {
    return [
      TrxCategory(id: "1", name: "Food", color: Colors.red),
      TrxCategory(id: "2", name: "Investments", color: Colors.pink),
      TrxCategory(id: "3", name: "Gift", color: Colors.orange),
    ];
  }

  @override
  List<Wallet> getAllWallets() {
    var box = Hive.box<Wallet>('walletsBox');

    if (box.values.length == 0) {
      var defaultWallet =
          Wallet(name: "Default", amount: 0.0, type: WalletType.card);

      box.put(
        defaultWallet.id,
        defaultWallet,
      );
    }

    print(box.values.length);

    return box.values.toList();
  }

  @override
  void updateTrxCategory() {
    print("updateTrxCategory() from service");
  }

  @override
  void updateWallet() {
    print("updateWallet() from service");
  }

  @override
  void addReminder() {
    print("addReminder() from service");
  }

  @override
  void updateReminder() {
    print("updateReminder() from service");
  }

  @override
  void deleteReminder() {
    print("deleteReminder() from service");
  }

  @override
  List<Reminder> getAllReminders() {
    return [
      Reminder(
          id: "1", name: "Add salary", frequency: "Every month 10. at 12h"),
      Reminder(id: "2", name: "Add food", frequency: "Every day at 6h")
    ];
  }

  @override
  void addTrx() {
    print("addTrx() from service");
    // TODO: implement addTrx
  }

  @override
  void deleteTrx() {
    print("deleteTrx() from service");
    // TODO: implement deleteTrx
  }

  @override
  void updateTrx() {
    print("updateTrx() from service");
    // TODO: implement updateTrx
  }

  @override
  void copyTrx() {
    print("copyTrx() from service");
    // TODO: implement updateTrx
  }

  @override
  List<Transaction> getAllTransaction() {
    // TODO: implement getAllTransaction
    return [
      Transaction(
          id: "id1",
          amount: 1200000000.4,
          isIncome: true,
          category: TrxCategory(id: "3", name: "Gift", color: Colors.amber),
          date: DateTime.now(),
          desc: "desc1",
          name: "name1",
          wallet: Wallet(
              name: "OTP Bank", amount: 123456.0, type: WalletType.card)),
      Transaction(
          id: "id2",
          amount: 1221.4,
          isIncome: true,
          category: TrxCategory(id: "1", name: "Food", color: Colors.amber),
          date: DateTime.now(),
          desc: "desc2",
          name: "name2",
          wallet: Wallet(
              name: "Home wallet", amount: 1234.0, type: WalletType.cash)),
      Transaction(
          id: "id3",
          amount: 120.4,
          isIncome: false,
          category: TrxCategory(id: "3", name: "Gift", color: Colors.amber),
          date: DateTime.now(),
          desc: "desc1",
          name: "name1",
          wallet: Wallet(
              name: "OTP Bank", amount: 123456.0, type: WalletType.card)),
      Transaction(
          id: "id4",
          amount: 120.4,
          isIncome: false,
          category: TrxCategory(id: "3", name: "Gift", color: Colors.amber),
          date: DateTime.now(),
          desc: "desc1",
          name: "name1",
          wallet: Wallet(
              name: "OTP Bank", amount: 123456.0, type: WalletType.card)),
      Transaction(
          id: "id2",
          amount: 1221.4,
          isIncome: false,
          category: TrxCategory(id: "1", name: "Food", color: Colors.amber),
          date: DateTime.now(),
          desc: "desc2",
          name: "name2",
          wallet: Wallet(
              name: "Home wallet", amount: 1234.0, type: WalletType.cash))
    ];
  }
}
