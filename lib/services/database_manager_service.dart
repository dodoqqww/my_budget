//import 'package:math_expressions/math_expressions.dart';
//
import 'package:flutter/material.dart';
import 'package:my_budget/models/reminder.dart';
import 'package:my_budget/models/transaction_category.dart';
import 'package:my_budget/models/wallet.dart';

abstract class DatabaseManagerService {
  List<Wallet> getAllWallets();
  List<TrxCategory> getAllTrxCategorys();
  List<Reminder> getAllReminders();
  void addWallet();
  void deleteWallet();
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
  void deleteWallet() {
    print("deleteWallet() from service");
  }

  @override
  List<TrxCategory> getAllTrxCategorys() {
    return [
      TrxCategory(id: "1", name: "Food", color: Colors.red),
      TrxCategory(id: "2", name: "Investments", color: Colors.pink),
    ];
  }

  @override
  List<Wallet> getAllWallets() {
    return [
      Wallet(
          id: "1", name: "OTP card", amount: 123456.0, type: WalletType.card),
      Wallet(
          id: "2", name: "Home wallet", amount: 2234.0, type: WalletType.cash)
    ];
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
}
