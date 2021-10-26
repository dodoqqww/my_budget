import 'package:flutter/material.dart';
import 'package:my_budget/models/reminder.dart';
import 'package:my_budget/models/transaction_category.dart';
import 'package:my_budget/models/wallet.dart';
import 'package:my_budget/models/wallet_type.dart';
import 'package:my_budget/services/database_manager_service.dart';
import 'package:my_budget/services/service_locator.dart';

//ready v2
class AddEditCategoryScreenProvider with ChangeNotifier {
  DatabaseManagerService _storageService;

  AddEditCategoryScreenProvider() {
    _storageService = getIt<DatabaseManagerService>();
  }

  Color selectedCategoryColor = Colors.red;
  TrxCategory selectedCategory;

  List<TrxCategory> getAllCategorys =
      getIt<DatabaseManagerService>().getAllTrxCategorys();
  TrxCategory getTrxCategoryById(String id) =>
      getIt<DatabaseManagerService>().getTrxCategoryById(id);

  void changeSelectedCategoryColor(Color color) {
    selectedCategoryColor = color;
    notifyListeners();
  }

  void changeSelectedCategory(TrxCategory category) {
    selectedCategoryColor = category.getColor();
    selectedCategory = category;
    notifyListeners();
  }

  void addCategory(TrxCategory category) {
    print("add Category");
    _storageService.addTrxCategory(category);
    notifyListeners();
  }

  void updateCategory({
    @required String name,
  }) {
    print("update Category");
    var category = selectedCategory;
    category.name = name;
    category.colorCode = selectedCategoryColor.value;
    _storageService.updateTrxCategory(category);
    selectedCategory = category;
    notifyListeners();
  }

  void deleteCategory() {
    print("delete Category");
    _storageService.deleteTrxCategory(selectedCategory);
    notifyListeners();
  }
}

//ready v2
class WalletSettingsProvider with ChangeNotifier {
  DatabaseManagerService _storageService;

  WalletSettingsProvider() {
    _storageService = getIt<DatabaseManagerService>();
  }

  List<Wallet> getAllWallets = getIt<DatabaseManagerService>().getAllWallets();
  Wallet getWalletById(String id) =>
      getIt<DatabaseManagerService>().getWalletById(id);

  addWallet(Wallet wallet) {
    print("add wallet");
    print(wallet.toString());
    _storageService.addWallet(wallet);
    notifyListeners();
  }

  void updateWallet(Wallet wallet,
      {@required String name,
      @required double amount,
      @required WalletType type,
      @required List<String> transactions}) {
    print("update wallet");
    wallet.amount = amount;
    wallet.name = name;
    wallet.type = type;
    wallet.transactionsId = transactions;
    _storageService.updateWallet(wallet);
    notifyListeners();
  }

  void deleteWallet(Wallet wallet) async {
    print("delete wallet");
    await _storageService.deleteWallet(wallet);
    notifyListeners();
  }
}

//ready v2
class ReminderSettingsProvider with ChangeNotifier {
  DatabaseManagerService _storageService;

  ReminderSettingsProvider() {
    _storageService = _storageService = getIt<DatabaseManagerService>();
  }

  List<Reminder> getAllReminders =
      getIt<DatabaseManagerService>().getAllReminders();

  void addReminder(Reminder reminder) {
    print("add Reminder");
    _storageService.addReminder();
    notifyListeners();
  }

  void updateReminder(Reminder reminder) {
    print("update Reminder");
    _storageService.updateReminder();
    notifyListeners();
  }

  void deleteReminder(Reminder reminder) {
    print("delete Reminder");
    _storageService.deleteReminder();
    notifyListeners();
  }
}
