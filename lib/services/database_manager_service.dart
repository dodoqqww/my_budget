//import 'package:math_expressions/math_expressions.dart';
//
import 'package:my_budget/models/transaction_category.dart';
import 'package:my_budget/models/wallet.dart';

abstract class DatabaseManagerService {
  List<Wallet> getAllWallets();
  List<TrxCategory> getAllTrxCategorys();
  void addWallet();
  void deleteWallet();
  void updateWallet();
  void addTrxCategory();
  void deleteTrxCategory();
  void updateTrxCategory();
}

class HiveDatabaseManagerService extends DatabaseManagerService {
  @override
  void addTrxCategory() {
    print("addTrxCategory() from service");
  }

  @override
  void addWallet() {
    print("addWallet() from service");
  }

  @override
  void deleteTrxCategory() {
    print("deleteTrxCategory() from service");
  }

  @override
  void deleteWallet() {
    print("deleteWallet() from service");
  }

  @override
  List<TrxCategory> getAllTrxCategorys() {
    print("getAllTrxCategorys() from service");
  }

  @override
  List<Wallet> getAllWallets() {
    return [
      Wallet(
          id: "1", name: "OTP card", amount: 123456.0, type: WalletType.card),
      Wallet(
          id: "2", name: "Home wallet", amount: 2234.0, type: WalletType.cash)
    ];
  }

  @override
  void updateTrxCategory() {
    print("updateTrxCategory() from service");
  }

  @override
  void updateWallet() {
    print("updateWallet() from service");
  }
}
