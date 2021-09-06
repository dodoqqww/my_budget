import 'package:flutter/material.dart';
import 'package:my_budget/models/wallet.dart';
import 'package:my_budget/services/database_manager_service.dart';
import 'package:my_budget/services/service_locator.dart';

class SettingsScreenProvider with ChangeNotifier {
  List<Wallet> _allWallets;

  DatabaseManagerService _storageService;

  SettingsScreenProvider() {
    _storageService = getIt<DatabaseManagerService>();
    _allWallets = _storageService.getAllWallets();
  }

  List<Wallet> get allWallets => _allWallets;

  addWallet(Wallet wallet) {
    print("add wallet");
    _storageService.addWallet();
    notifyListeners();
  }

  updateWallet(Wallet wallet) {
    print("update wallet");
    _storageService.updateWallet();
    notifyListeners();
  }

  deleteWallet(Wallet wallet) {
    print("delete wallet");
    _storageService.deleteWallet();
    notifyListeners();
  }
}
