import 'package:flutter/material.dart';
import 'package:my_budget/models/reminder.dart';
import 'package:my_budget/models/transaction_category.dart';
import 'package:my_budget/models/wallet.dart';
import 'package:my_budget/services/database_manager_service.dart';
import 'package:my_budget/services/service_locator.dart';

class AddEditCategoryScreenProvider with ChangeNotifier {
  DatabaseManagerService _storageService;

  AddEditCategoryScreenProvider() {
    _storageService = getIt<DatabaseManagerService>();
    allCategorys = _storageService.getAllTrxCategorys();
  }

  Color selectedCategoryColor = Colors.red;
  List<TrxCategory> allCategorys;
  TrxCategory selectedCategory;

  changeSelectedCategoryColor(Color color) {
    selectedCategoryColor = color;
    notifyListeners();
  }

  changeSelectedCategory(TrxCategory category) {
    selectedCategoryColor = category.color;
    selectedCategory = category;
    notifyListeners();
  }

  addCategory() {
    print("add Category");
    _storageService.addTrxCategory();
    allCategorys.add(TrxCategory(id: "3", name: "Food", color: Colors.green));
    notifyListeners();
  }

  updateCategory() {
    print("update Category");
    _storageService.updateTrxCategory();
    notifyListeners();
  }

  deleteCategory() {
    print("delete Category");
    _storageService.deleteTrxCategory();
    notifyListeners();
  }
}

class WalletSettingsProvider with ChangeNotifier {
  DatabaseManagerService _storageService;

  WalletSettingsProvider() {
    _storageService = _storageService = getIt<DatabaseManagerService>();
    allWallets = _storageService.getAllWallets();
  }

  List<Wallet> allWallets;
  Wallet selectedWallet;

  addWallet(Wallet wallet) {
    print("add wallet");
    _storageService.addWallet();
    allWallets.add(wallet);
    notifyListeners();
  }

  updateWallet(Wallet wallet) {
    print("update wallet");
    _storageService.updateWallet();
    notifyListeners();
  }

  deleteWallet(Wallet wallet) async {
    print("delete wallet");
    await _storageService.deleteWallet(wallet);
    notifyListeners();
  }
}

class ReminderSettingsProvider with ChangeNotifier {
  DatabaseManagerService _storageService;

  ReminderSettingsProvider() {
    _storageService = _storageService = getIt<DatabaseManagerService>();
    allReminders = _storageService.getAllReminders();
  }

  List<Reminder> allReminders;
  Wallet selectedWallet;

  addReminder(Reminder reminder) {
    print("add Reminder");
    _storageService.addReminder();
    allReminders.add(reminder);
    notifyListeners();
  }

  updateReminder(Reminder reminder) {
    print("update Reminder");
    _storageService.updateReminder();
    notifyListeners();
  }

  deleteReminder(Reminder reminder) {
    print("delete Reminder");
    _storageService.deleteReminder();
    notifyListeners();
  }
}
