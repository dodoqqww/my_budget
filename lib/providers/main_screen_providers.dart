import 'package:flutter/material.dart';
import 'package:my_budget/models/transaction.dart';
import 'package:my_budget/models/transaction_category.dart';
import 'package:my_budget/models/wallet.dart';
import 'package:my_budget/services/database_manager_service.dart';
import 'package:my_budget/services/service_locator.dart';
import 'package:my_budget/services/transaction_manager_service.dart';

//ready
class IncomeWidgetProvider with ChangeNotifier {
  TransactionManagerService _trxManagerService;
  DatabaseManagerService _storageService;
  DateTime _selectedDate;

  set selectedDate(DateTime date) => _selectedDate = date;

  IncomeWidgetProvider() {
    _trxManagerService = getIt<TransactionManagerService>();
    _storageService = getIt<DatabaseManagerService>();
  }

  double sumIncome() => _trxManagerService.getSumTrxAmount(allIncomeTrxs());

  List<Transaction> allIncomeTrxs() => _trxManagerService
      .getIncomeTrxs(_storageService.getAllTransactionByMonth(_selectedDate));

  void refreshIncomeWidget() {
    print("refreshIncomeWidget()");
    notifyListeners();
  }
}

//ready
class ExpenseWidgetProvider with ChangeNotifier {
  TransactionManagerService _trxManagerService;
  DatabaseManagerService _storageService;

  DateTime _selectedDate;

  set selectedDate(DateTime date) => _selectedDate = date;

  ExpenseWidgetProvider() {
    _trxManagerService = getIt<TransactionManagerService>();
    _storageService = getIt<DatabaseManagerService>();
  }

  double sumExpense() => _trxManagerService.getSumTrxAmount(allExpenseTrxs());

  List<Transaction> allExpenseTrxs() => _trxManagerService
      .getExpenseTrxs(_storageService.getAllTransactionByMonth(_selectedDate));

  void refreshExpenseWidget() {
    print("refreshExpenseWidget()");
    notifyListeners();
  }
}

//ready
class MainScreenProvider with ChangeNotifier {
  DateTime selectedDate;

  MainScreenProvider() {
    selectedDate = DateTime.now();
  }

  void changeDate(DateTime newDate) {
    selectedDate = newDate;
    notifyListeners();
  }
}

//ready
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
  void addTrx(
      {@required double amount,
      @required String desc,
      @required DateTime date,
      @required bool isIncome}) {
    print("added Trasaction Amount: $amount IsIncome: $isIncome Date: $date");
    _storageService.addTrx(Transaction(
        categoryId: selectedAddCategory.id,
        isIncome: isIncome,
        date: date,
        amount: amount,
        desc: desc,
        walletId: selectedAddWallet.id));
    notifyListeners();
  }

  //ready
  void updateTrx(Transaction trx,
      {@required String desc,
      @required double amount,
      @required DateTime time}) {
    print("updated Trasaction Id: ${trx.id}");
    double oldAmount = trx.amount;
    trx.amount = amount;
    trx.desc = desc;
    trx.walletId = selectedEditWallet.id;
    trx.categoryId = selectedEditCategory.id;
    trx.date = time;
    _storageService.updateTrx(trx, oldAmount);
    notifyListeners();
  }

  //ready
  void copyTrx(Transaction trx, DateTime selectedDate) {
    print("copied Trasaction Id: ${trx.id}");
    _storageService.copyTrx(trx, selectedDate);
    notifyListeners();
  }

  //ready
  void deleteTrx(Transaction trx) {
    print("deleted Trasaction Id: ${trx.id}");
    _storageService.deleteTrx(trx);
    notifyListeners();
  }
}
