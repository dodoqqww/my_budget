import 'package:flutter/material.dart';
import 'package:my_budget/models/reminder.dart';
import 'package:my_budget/models/transaction_category.dart';
import 'package:my_budget/models/wallet.dart';
import 'package:my_budget/models/wallet_type.dart';
import 'package:my_budget/services/database_manager_service.dart';
import 'package:my_budget/services/service_locator.dart';

//ready
class AddEditCategoryScreenProvider with ChangeNotifier {
  DatabaseManagerService _storageService;

  AddEditCategoryScreenProvider() {
    _storageService = getIt<DatabaseManagerService>();
  }

  Color selectedCategoryColor = Colors.red;
  TrxCategory selectedCategory;

  List<TrxCategory> getAllCategorys() => _storageService.getAllTrxCategorys();

  TrxCategory getTrxCategoryById(String id) =>
      _storageService.getTrxCategoryById(id);

  void changeSelectedCategoryColor(Color color) {
    print(
        "changeSelectedCategoryColor() Color: ${selectedCategoryColor.value}");
    selectedCategoryColor = color;
    notifyListeners();
  }

  void changeSelectedCategory(TrxCategory category) {
    print("changeSelectedCategory() Id: ${selectedCategory.id}");
    selectedCategoryColor = category.getColor();
    selectedCategory = category;
    notifyListeners();
  }

  void addCategory(TrxCategory category) {
    print("added: ${category.toString()}");
    _storageService.addTrxCategory(category);
    notifyListeners();
  }

  void updateCategory({
    @required String name,
  }) {
    print("updated Category Id: ${selectedCategory.id}");
    var category = selectedCategory;
    category.name = name;
    category.colorCode = selectedCategoryColor.value;
    _storageService.updateTrxCategory(category);
    selectedCategory = category;
    notifyListeners();
  }

  void deleteCategory() {
    print("deleted Category Id: ${selectedCategory.id}");
    _storageService.deleteTrxCategory(selectedCategory);
    notifyListeners();
  }
}

//ready
class WalletSettingsProvider with ChangeNotifier {
  DatabaseManagerService _storageService;

  WalletSettingsProvider() {
    _storageService = getIt<DatabaseManagerService>();
  }

  List<Wallet> getAllWallets() => _storageService.getAllWallets();

  Wallet getWalletById(String id) => _storageService.getWalletById(id);

  void addWallet(Wallet wallet) {
    print("added: ${wallet.toString()}");
    _storageService.addWallet(wallet);
    notifyListeners();
  }

  void updateWallet(Wallet wallet,
      {@required String name,
      @required double amount,
      @required WalletType type,
      @required List<String> transactions}) {
    print("updated Wallet Id: ${wallet.id}");
    wallet.amount = amount;
    wallet.name = name;
    wallet.type = type;
    wallet.transactionsId = transactions;
    _storageService.updateWallet(wallet);
    notifyListeners();
  }

  void deleteWallet(Wallet wallet) {
    _storageService.deleteWallet(wallet);
    print("deleted Wallet Id: ${wallet.id}");
    notifyListeners();
  }
}

//ready
class ReminderSettingsProvider with ChangeNotifier {
  DatabaseManagerService _storageService;

  ReminderSettingsProvider() {
    _storageService = _storageService = getIt<DatabaseManagerService>();
  }

  List<Reminder> getAllReminders() => _storageService.getAllReminders();

  void addReminder(Reminder reminder) {
    print("added: ${reminder.toString()}");
    _storageService.addReminder();
    notifyListeners();
  }

  void updateReminder(Reminder reminder) {
    print("updated Reminder Id: ${reminder.id}");
    _storageService.updateReminder();
    notifyListeners();
  }

  void deleteReminder(Reminder reminder) {
    print("deleted Reminder Id: ${reminder.id}");
    _storageService.deleteReminder();
    notifyListeners();
  }
}
