import 'package:flutter/material.dart';
import 'package:my_budget/models/transaction.dart';
import 'package:my_budget/models/transaction_category.dart';
import 'package:my_budget/models/wallet.dart';
import 'package:my_budget/services/database_manager_service.dart';
import 'package:my_budget/services/service_locator.dart';
import 'package:my_budget/services/transaction_manager_service.dart';

class IncomeWidgetProvider with ChangeNotifier {
  TransactionManagerService _trxManagerService;
  DatabaseManagerService _storageService;

  IncomeWidgetProvider() {
    _trxManagerService = getIt<TransactionManagerService>();
    _storageService = getIt<DatabaseManagerService>();
    allIncomeTrxs =
        _trxManagerService.getIncomeTrxs(_storageService.getAllTransaction());
    sumIncome = _trxManagerService.getSumTrxAmount(allIncomeTrxs);
  }

  double sumIncome;
  List<Transaction> allIncomeTrxs;

  double getSumIncome({DateTime month}) {
    print("getSumExpense()");
    print(month);
    return sumIncome;
  }

  List<Transaction> getAllExpenseTrxs({DateTime month}) {
    print("getAllExpenseTrxs()");
    print(month);
    return allIncomeTrxs;
  }

  addTrx() {
    print("add inTrx");
    _storageService.addTrx();
    // sumIncome = _trxManagerService.getSumIncome();
    // sumExpense = _trxManagerService.getSumExpense();
    notifyListeners();
  }

  deleteTrx() {
    print("delete inTrx");
    _storageService.deleteTrx();
    // sumIncome = _trxManagerService.getSumIncome();
    // sumExpense = _trxManagerService.getSumExpense();
    notifyListeners();
  }

  updateTrx() {
    print("update inTrx");
    _storageService.updateTrx();
    // sumIncome = _trxManagerService.getSumIncome();
    // sumExpense = _trxManagerService.getSumExpense();
    notifyListeners();
  }
}

class ExpenseWidgetProvider with ChangeNotifier {
  TransactionManagerService _trxManagerService;
  DatabaseManagerService _storageService;

  ExpenseWidgetProvider() {
    _trxManagerService = getIt<TransactionManagerService>();
    _storageService = getIt<DatabaseManagerService>();
    allExpenseTrxs =
        _trxManagerService.getExpenseTrxs(_storageService.getAllTransaction());
    sumExpense = _trxManagerService.getSumTrxAmount(allExpenseTrxs);
  }

  // double sumIncome;
  double sumExpense;
  // List<Transaction> allIncomeTrxs;
  List<Transaction> allExpenseTrxs;

  double getSumExpense({DateTime month}) {
    print("getSumExpense()");
    print(month);
    return sumExpense;
  }

  List<Transaction> getAllExpenseTrxs({DateTime month}) {
    print("getAllExpenseTrxs()");
    print(month);
    return allExpenseTrxs;
  }

  addTrx() {
    print("add exTrx");
    _storageService.addTrx();
    // sumIncome = _trxManagerService.getSumIncome();
    // sumExpense = _trxManagerService.getSumExpense();
    notifyListeners();
  }

  deleteTrx() {
    print("delete exTrx");
    _storageService.deleteTrx();
    // sumIncome = _trxManagerService.getSumIncome();
    // sumExpense = _trxManagerService.getSumExpense();
    notifyListeners();
  }

  updateTrx() {
    print("update exTrx");
    _storageService.updateTrx();
    // sumIncome = _trxManagerService.getSumIncome();
    // sumExpense = _trxManagerService.getSumExpense();
    notifyListeners();
  }
}

class MainScreenProvider with ChangeNotifier {
  DateTime selectedDate;

  MainScreenProvider() {
    selectedDate = DateTime.now();
  }

  changeDate(DateTime newDate) {
    selectedDate = newDate;
    notifyListeners();
  }
}

class AddEditTrxScreenProvider with ChangeNotifier {
  DatabaseManagerService _storageService;

  AddEditTrxScreenProvider() {
    _storageService = getIt<DatabaseManagerService>();
    allCategorys = _storageService.getAllTrxCategorys();
    allWallets = _storageService.getAllWallets();
    selectedAddWallet = allWallets[0];
    selectedAddCategory = allCategorys[0];
  }

  TrxCategory selectedAddCategory;
  TrxCategory selectedEditCategory;
  Wallet selectedAddWallet;
  Wallet selectedEditWallet;

  List<TrxCategory> allCategorys;
  List<Wallet> allWallets;

  changeSelectedAddCategory(TrxCategory category) {
    selectedAddCategory = category;
    notifyListeners();
  }

  changeSelectedEditCategory(TrxCategory category) {
    selectedEditCategory = category;
    notifyListeners();
  }

  changeSelectedEditWallet(Wallet wallet) {
    selectedEditWallet = wallet;
    notifyListeners();
  }

  changeSelectedAddWallet(Wallet wallet) {
    selectedAddWallet = wallet;
    notifyListeners();
  }

  addTrx() {
    print("add Trx");
    _storageService.addTrx();
    notifyListeners();
  }

  updateTrx() {
    print("update Trx");
    _storageService.updateTrx();
    notifyListeners();
  }

  copyTrx() {
    print("copy Trx");
    _storageService.copyTrx();
    notifyListeners();
  }

  deleteTrx() {
    print("delete Trx");
    _storageService.deleteTrx();
    notifyListeners();
  }
}
