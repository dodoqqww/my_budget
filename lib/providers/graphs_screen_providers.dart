import 'package:flutter/material.dart';
import 'package:my_budget/services/database_manager_service.dart';
import 'package:my_budget/services/graphs_manager_service.dart';
import 'package:my_budget/services/service_locator.dart';
import 'package:my_budget/ui/widgets/chart_widgets.dart';
import 'package:my_budget/ui/widgets/legend_widget.dart';

class GraphsScreenProvider with ChangeNotifier {
  GraphsManagerService _graphsManagerService;

  GraphsScreenProvider() {
    _graphsManagerService = getIt<GraphsManagerService>();

    selectedDate = DateTime.now();
  }

  DateTime selectedDate;

  List<MyLegendWidget> getLegendsDatasByDate() =>
      _graphsManagerService.getLegendsDatasByDate(selectedDate);

  List<TimeSeriesSales> getMonthChartDatasByDate() =>
      _graphsManagerService.getMonthChartDatasByDate(selectedDate);

  List<LinearSales> getPieChartDatasByDate() =>
      _graphsManagerService.getPieChartDatasByDate(selectedDate);

  List<List<OrdinalSales>> getPreviousMonthsDatasByDate() =>
      _graphsManagerService.getPreviousMonthsDatasByDate(selectedDate);

  void changeSelectedDate(DateTime newDate) {
    print("changeSelectedDate() in GraphsScreenProvider");
    selectedDate = newDate;
    notifyListeners();
  }
}
