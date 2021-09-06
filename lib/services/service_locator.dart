import 'package:get_it/get_it.dart';
import 'package:my_budget/services/database_manager_service.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  getIt.registerLazySingleton<DatabaseManagerService>(
      () => HiveDatabaseManagerService());
}
