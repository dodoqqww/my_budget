import 'package:get_it/get_it.dart';
import 'package:my_budget/services/database_manager_service.dart';
import 'package:my_budget/services/transaction_manager_service.dart';

import 'graphs_manager_service.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  getIt.registerLazySingleton<DatabaseManagerService>(
      () => HiveDatabaseManagerService());
  getIt.registerLazySingleton<TransactionManagerService>(
      () => AppTransactionManagerService());
  getIt.registerLazySingleton<GraphsManagerService>(
      () => AppGraphsManagerService());
}
