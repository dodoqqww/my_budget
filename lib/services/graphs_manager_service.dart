import 'package:my_budget/models/transaction_category.dart';
import 'package:my_budget/services/database_manager_service.dart';
import 'package:my_budget/services/service_locator.dart';
import 'package:my_budget/ui/widgets/chart_widgets.dart';
import 'package:my_budget/ui/widgets/legend_widget.dart';
import 'package:my_budget/utils/util_methods.dart';

abstract class GraphsManagerService {
  List<TimeSeriesSales> getMonthChartDatasByDate(DateTime month);
  List<LinearSales> getPieChartDatasByDate(DateTime month);
  List<List<OrdinalSales>> getPreviousMonthsDatasByDate(DateTime month);
  List<MyLegendWidget> getLegendsDatasByDate(DateTime month);
}

class AppGraphsManagerService extends GraphsManagerService {
  //ready
  @override
  List<MyLegendWidget> getLegendsDatasByDate(DateTime month) {
    print("getLegendsDatasByData() from service");

    DatabaseManagerService databaseManagerService =
        getIt<DatabaseManagerService>();

    var trxs = databaseManagerService
        .getAllTransactionByMonth(month)
        .where((element) => element.isIncome == false)
        .toList();

    var categorys = databaseManagerService.getAllTrxCategorys();

    List<MyLegendWidget> datas = [];

    List<String> datasId = [];

    trxs.forEach((trx) {
      if (!datasId.contains(trx.categoryId)) {
        datasId.add(trx.categoryId);

        var category =
            categorys.firstWhere((element) => element.id == trx.categoryId);

        datas.add(
            MyLegendWidget(text: category.name, color: category.getColor()));
      }
    });

    return datas;
  }

  //ready
  @override
  List<TimeSeriesSales> getMonthChartDatasByDate(DateTime month) {
    print("getMonthChartDatasByDate() from service");
    DatabaseManagerService databaseManagerService =
        getIt<DatabaseManagerService>();

    var trxs = databaseManagerService.getAllTransactionByMonth(month);
    trxs.sort((a, b) => a.date.compareTo(b.date));

    if (trxs.length == 0) {
      return [];
    }

    List<TimeSeriesSales> datas = [];

    List<DateTime> trxsDate = [DateTime(month.year, month.month, 0)];
    List<double> trxsAmount = [0];

    double sumAmount = 0;

    for (int i = 0; i < trxs.length; i++) {
      if (trxs[i].date == trxsDate.last) {
        trxs[i].isIncome
            ? trxsAmount[trxsDate.length - 1] += trxs[i].amount
            : trxsAmount[trxsDate.length - 1] -= trxs[i].amount;
      } else {
        trxsDate.add(trxs[i].date);

        trxs[i].isIncome
            ? trxsAmount.add(sumAmount + trxs[i].amount)
            : trxsAmount.add(sumAmount - trxs[i].amount);

        trxs[i].isIncome
            ? sumAmount += trxs[i].amount
            : sumAmount -= trxs[i].amount;
      }
    }

    bool previousIsIncome = trxsAmount[1] >= 0;

    datas.add(TimeSeriesSales(
        DateTime(month.year, month.month, 0), 0, previousIsIncome));

    int i = 1;

    while (i + 1 < trxsDate.length) {
      previousIsIncome = trxsAmount[i + 1] >= trxsAmount[i] ? true : false;

      //print(previousIsIncome);

      datas.add(TimeSeriesSales(
          DateTime(month.year, month.month, trxsDate[i].day),
          trxsAmount[i].toInt(),
          previousIsIncome));

      i++;
    }

    //previousIsIncome = trxsAmount[i + 1] >= 0 ? true : false;

    datas.add(TimeSeriesSales(
        DateTime(month.year, month.month, trxsDate[i].day),
        trxsAmount[i].toInt(),
        previousIsIncome));

    // print("last: $lastAmount");a

    return datas;
  }

  //ready
  @override
  List<LinearSales> getPieChartDatasByDate(DateTime month) {
    print("getPieChartDatasByDate() from service");
    DatabaseManagerService databaseManagerService =
        getIt<DatabaseManagerService>();

    var trxs = databaseManagerService
        .getAllTransactionByMonth(month)
        .where((element) => element.isIncome == false)
        .toList();

    var categorys = databaseManagerService.getAllTrxCategorys();

    double sumAmount = 0;
    Map<TrxCategory, double> categorySumMap = Map();

    trxs.forEach((trx) {
      sumAmount += trx.amount;

      var category =
          categorys.firstWhere((element) => element.id == trx.categoryId);

      if (categorySumMap[category] != null) {
        var oldAmount = categorySumMap[category];
        categorySumMap.update(
            category, (value) => value = oldAmount + trx.amount);
      } else {
        categorySumMap[category] = trx.amount;
      }
    });

    List<LinearSales> datas = [];

    categorySumMap.forEach((key, value) {
      //  print(key.name + "  " + value.toString());
      datas.add(LinearSales(
          key.name, (value / sumAmount * 100).toInt(), key.getColor()));
    });

    return datas;

    // [
    //   new LinearSales("Food", 100, Colors.amber),
    //   new LinearSales("Investment", 75, Colors.green),
    //   new LinearSales("Invoices", 25, Colors.cyan),
    //   new LinearSales("3", 5, Colors.pink),
    //   new LinearSales("4", 100, Colors.blue),
    // ];
  }

  @override
  List<List<OrdinalSales>> getPreviousMonthsDatasByDate(DateTime month) {
    print("getPreviousMonthsDatasByDate() from service");

    List<List<OrdinalSales>> data = [];

    // DateTime date1 = DateTime(month.year, month.month - 2, 1);
    // DateTime date2 = DateTime(month.year, month.month - 1, 1);
    // DateTime date3 = DateTime(month.year, month.month, 1);

    List<OrdinalSales> first = [];
    List<OrdinalSales> second = [];
    List<OrdinalSales> third = [];

    DatabaseManagerService databaseManagerService =
        getIt<DatabaseManagerService>();

    double totalSum = 0;

    for (int i = 2; i >= 0; i--) {
      DateTime date = DateTime(month.year, month.month - i, 1);

      double income = databaseManagerService
          .getAllTransactionByMonth(date)
          .where((element) => element.isIncome == true)
          .toList()
          .fold(0, (previousValue, element) => previousValue + element.amount);

      double expense = databaseManagerService
          .getAllTransactionByMonth(date)
          .where((element) => element.isIncome == false)
          .toList()
          .fold(0, (previousValue, element) => previousValue + element.amount);

      // print("expense: $expense month: $month i: $i");

      first.add(OrdinalSales(getFormatedyyyyMMMDate(date), income.toInt()));
      second
          .add(OrdinalSales(getFormatedyyyyMMMDate(date), 0 - expense.toInt()));

      totalSum += (income - expense);

      third.add(OrdinalSales(getFormatedyyyyMMMDate(date), totalSum.toInt()));
    }
    data.add(first);
    data.add(second);
    data.add(third);

    return data;
  }
}
