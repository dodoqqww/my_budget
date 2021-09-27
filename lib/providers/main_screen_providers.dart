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

  refreshIncome({@required DateTime month}) {
    print("getSumExpense()");
    allIncomeTrxs =
        _trxManagerService.getIncomeTrxs(_storageService.getAllTransaction());
    sumIncome = _trxManagerService.getSumTrxAmount(allIncomeTrxs);
    print(month);
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

  refreshExpense({@required DateTime month}) {
    print("getSumExpense()");
    allExpenseTrxs =
        _trxManagerService.getExpenseTrxs(_storageService.getAllTransaction());
    sumExpense = _trxManagerService.getSumTrxAmount(allExpenseTrxs);
    print(month);
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
    selectedAddWallet = _storageService.getAllWallets()[0];
    selectedAddCategory = _storageService.getAllTrxCategorys()[0];
  }

  TrxCategory selectedAddCategory;
  TrxCategory selectedEditCategory;
  Wallet selectedAddWallet;
  Wallet selectedEditWallet;

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

  //ready
  addTrx(
      {@required double amount,
      @required String desc,
      @required DateTime date,
      @required bool isIncome}) async {
    print("add Trx");
    print(date);
    await _storageService.addTrx(Transaction(
        categoryId: selectedAddCategory.id,
        isIncome: isIncome,
        date: date,
        amount: amount,
        desc: desc,
        walletId: selectedAddWallet.id));
    notifyListeners();
  }

  //ready
  updateTrx(Transaction trx,
      {@required String desc,
      @required double amount,
      @required DateTime time}) {
    print("update Trx");
    trx.amount = amount;
    trx.desc = desc;
    trx.walletId = selectedEditWallet.id;
    trx.categoryId = selectedEditCategory.id;
    trx.date = time;
    _storageService.updateTrx(trx);
    notifyListeners();
  }

  copyTrx() {
    print("copy Trx");
    _storageService.copyTrx();
    notifyListeners();
  }

  //ready
  deleteTrx(Transaction trx) {
    print("delete Trx");
    _storageService.deleteTrx(trx);
    notifyListeners();
  }
}
