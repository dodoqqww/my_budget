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
    // TODO: implement getSumExpense
    return trxs.fold(
        0, (previousValue, element) => previousValue + element.amount);
  }

  @override
  List<Transaction> getExpenseTrxs(List<Transaction> trxs) {
    print("getExpenseTrxs() from service");
    // TODO: implement getExpenseTrxs
    return trxs.where((element) => element.isIncome == false).toList();
  }

  @override
  List<Transaction> getIncomeTrxs(List<Transaction> trxs) {
    print("getIncomeTrxs() from service");
    // TODO: implement getIncomeTrxs
    return trxs.where((element) => element.isIncome == true).toList();
  }
}
