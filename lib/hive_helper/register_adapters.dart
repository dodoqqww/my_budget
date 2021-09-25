import 'package:hive/hive.dart';
import 'package:my_budget/models/wallet.dart';
import 'package:my_budget/models/wallet_type.dart';
import 'package:my_budget/models/transaction_category.dart';

void registerAdapters() {
  Hive.registerAdapter(WalletAdapter());
  Hive.registerAdapter(WalletTypeAdapter());
	Hive.registerAdapter(TrxCategoryAdapter());
}
