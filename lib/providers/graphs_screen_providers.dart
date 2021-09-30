import 'package:flutter/material.dart';
import 'package:my_budget/services/database_manager_service.dart';
import 'package:my_budget/services/graphs_manager_service.dart';
import 'package:my_budget/services/service_locator.dart';

class GraphsScreenProvider with ChangeNotifier {
  DatabaseManagerService _storageService;

  GraphsManagerService _graphsManagerService;

  GraphsScreenProvider() {
    _storageService = getIt<DatabaseManagerService>();
    _graphsManagerService = getIt<GraphsManagerService>();

    selectedDate = DateTime.now();
  }
  DateTime selectedDate;

  void changeSelectedDate(DateTime newDate) {
    print("changeSelectedDate()");
    selectedDate = newDate;
    notifyListeners();
  }

  // getPieChartDatas() {
  //   print("getPieChartDatas()");
  //   _graphsManagerService.getPieChartDatasByDate();
  //   notifyListeners();
  // }
//
  // getMonthChartDatas() {
  //   print("getMonthChartDatas()");
  //   _graphsManagerService.getMonthChartDatasByDate();
  //   notifyListeners();
  // }
//
  // getPreviousMonthsDatas() {
  //   print("getPreviousMonthsDatas()");
  //   _graphsManagerService.getPreviousMonthsDatasByDate();
  //   notifyListeners();
  // }
//
  // getLegendsDatas() {
  //   print("getLegendsDatas()");
  //   _graphsManagerService.getLegendsDatasByDate();
  //   notifyListeners();
  // }
}
