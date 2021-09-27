import 'package:my_budget/models/transaction.dart';
import 'package:my_budget/services/database_manager_service.dart';

abstract class TransactionManagerService {
  double getSumTrxAmount(List<Transaction> trxs);
  List<Transaction> getIncomeTrxs(List<Transaction> trxs);
  List<Transaction> getExpenseTrxs(List<Transaction> trxs);
}

class AppTransactionManagerService extends TransactionManagerService {
  @override
  double getSumTrxAmount(List<Transaction> trxs) {
    print("getSumExpense() from service");
    return trxs.fold(
        0, (previousValue, element) => previousValue + element.amount);
  }

  @override
  List<Transaction> getExpenseTrxs(List<Transaction> trxs) {
    print("getExpenseTrxs() from service");
    List<Transaction> list =
        trxs.where((element) => element.isIncome == false).toList();
    list.sort((a, b) => a.date.compareTo(b.date));
    return list;
  }

  @override
  List<Transaction> getIncomeTrxs(List<Transaction> trxs) {
    print("getIncomeTrxs() from service");
    List<Transaction> list =
        trxs.where((element) => element.isIncome == true).toList();
    list.sort((a, b) => a.date.compareTo(b.date));
    return list;
  }
}
