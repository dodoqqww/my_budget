import 'package:flutter/material.dart';
import 'package:my_budget/models/transaction.dart';
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
