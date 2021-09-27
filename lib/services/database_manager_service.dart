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
  List<Transaction> getAllTransactionByMonth(DateTime month);
  Future<void> addTrx(Transaction trx);
  void copyTrx();
  void deleteTrx(Transaction trx);
  void updateTrx(Transaction trx);
  void addWallet(Wallet wallet);
  Future<void> deleteWallet(Wallet wallet);
  Future<void> updateWallet(Wallet wallet);
  void addTrxCategory(TrxCategory category);
  void deleteTrxCategory(TrxCategory category);
  void updateTrxCategory(TrxCategory category);
  void addReminder();
  void deleteReminder();
  void updateReminder();
  Wallet getWalletById(String id);
  TrxCategory getTrxCategoryById(String id);
}

class HiveDatabaseManagerService extends DatabaseManagerService {
  //ready
  @override
  void addTrxCategory(TrxCategory category) {
    var box = Hive.box<TrxCategory>('trxCategoryBox');
    box.put(
      category.id,
      category,
    );
  }

  //ready
  @override
  void addWallet(Wallet wallet) {
    var box = Hive.box<Wallet>('walletsBox');
    box.put(
      wallet.id,
      wallet,
    );
  }

  //ready
  @override
  void deleteTrxCategory(TrxCategory category) {
    var box = Hive.box<TrxCategory>('trxCategoryBox');
    box.delete(category.id);
  }

  //ready
  @override
  Future<void> deleteWallet(Wallet wallet) async {
    var box = Hive.box<Wallet>('walletsBox');
    await box.delete(wallet.id);
  }

  //ready
  @override
  List<TrxCategory> getAllTrxCategorys() {
    var box = Hive.box<TrxCategory>('trxCategoryBox');
    if (box.values.length == 0) {
      print("add default");
      var defaultTrxCategory =
          TrxCategory(name: "Food", colorCode: Colors.green.value);
      box.put(
        defaultTrxCategory.id,
        defaultTrxCategory,
      );
    }
    return box.values.toList();
  }

  //ready
  @override
  List<Wallet> getAllWallets() {
    var box = Hive.box<Wallet>('walletsBox');
    if (box.values.length == 0) {
      print("add default");
      var defaultWallet = Wallet(
          name: "Default",
          amount: 0.0,
          type: WalletType.card,
          transactionsId: []);
      box.put(
        defaultWallet.id,
        defaultWallet,
      );
    }
    return box.values.toList();
  }

  //ready
  @override
  void updateTrxCategory(TrxCategory category) {
    var box = Hive.box<TrxCategory>('trxCategoryBox');
    //box.delete(category.id);
    box.put(
      category.id,
      category,
    );
  }

  //ready
  @override
  Future<void> updateWallet(Wallet wallet) async {
    var box = Hive.box<Wallet>('walletsBox');
    // await box.delete(wallet.id);
    box.put(
      wallet.id,
      wallet,
    );
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

  //ready
  @override
  Future<void> addTrx(Transaction trx) async {
    print("addTrx() from service");
    var box = Hive.box<Transaction>('trxBox');
    Wallet wallet = getWalletById(trx.walletId);
    wallet.transactionsId.add(trx.id);
    await updateWallet(wallet);
    box.put(trx.id, trx);
  }

  //ready
  @override
  void deleteTrx(Transaction trx) {
    print("deleteTrx() from service");
    var box = Hive.box<Transaction>('trxBox');
    box.delete(trx.id);
  }

  //ready
  @override
  void updateTrx(Transaction trx) {
    print("updateTrx() from service");
    var box = Hive.box<Transaction>('trxBox');
    box.put(trx.id, trx);
  }

  @override
  void copyTrx() {
    print("copyTrx() from service");
    // TODO: implement updateTrx
  }

  //ready
  @override
  List<Transaction> getAllTransactionByMonth(DateTime month) {
    var box = Hive.box<Transaction>('trxBox');
    return box.values
        .where((element) => (element.date.year == month.year &&
            element.date.month == month.month))
        .toList();
  }

  //ready
  @override
  Wallet getWalletById(String id) {
    var box = Hive.box<Wallet>('walletsBox');
    print("id: " + id);
    print(box.values);
    return box.values.firstWhere((element) => element.id == id, orElse: () {
      return Wallet.fromId(id: id);
    });
  }

  //ready
  @override
  TrxCategory getTrxCategoryById(String id) {
    var box = Hive.box<TrxCategory>('trxCategoryBox');
    print("id: " + id);
    print(box.values);
    return box.values.firstWhere((element) => element.id == id, orElse: () {
      return TrxCategory.fromId(id: id);
    });
  }
}
