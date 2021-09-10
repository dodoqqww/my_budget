abstract class GraphsManagerService {
  void getMonthChartDatasByDate();
  void getPieChartDatasByDate();
  void getPreviousMonthsDatasByDate();
  void getLegendsDatasByDate();
}

class AppGraphsManagerService extends GraphsManagerService {
  @override
  void getLegendsDatasByDate() {
    print("getLegendsDatasByData() from service");
  }

  @override
  void getMonthChartDatasByDate() {
    print("getMonthChartDatasByDate() from service");
  }

  @override
  void getPieChartDatasByDate() {
    print("getPieChartDatasByDate() from service");
  }

  @override
  void getPreviousMonthsDatasByDate() {
    print("getPreviousMonthsDatasByDate() from service");
  }
}
