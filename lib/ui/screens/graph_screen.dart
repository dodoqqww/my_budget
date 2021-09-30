import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:my_budget/providers/graphs_screen_providers.dart';
import 'package:my_budget/services/graphs_manager_service.dart';
import 'package:my_budget/services/service_locator.dart';
import 'package:my_budget/ui/widgets/chart_widgets.dart';
import 'package:my_budget/ui/widgets/legend_widget.dart';
import 'package:my_budget/utils/util_methods.dart';
import './/ui/common/style.dart';
import 'package:provider/provider.dart';

class GraphScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("GraphScreen build()");
    final GraphsManagerService graphsManagerService =
        getIt<GraphsManagerService>();
    final graphsScreenProvider = context.watch<GraphsScreenProvider>();
    return Scaffold(
      body: Container(
        //padding: EdgeInsets.all(10),
        child: StaggeredGridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          //mainAxisSpacing: 1,
          //mainAxisSpacing: 4,
          children: <Widget>[
            LastFourMonthChartWidget(
                graphsManagerService: graphsManagerService,
                month: graphsScreenProvider.selectedDate),
            PieChart(
                graphsManagerService: graphsManagerService,
                month: graphsScreenProvider.selectedDate),
            MonthSelectorWidget(),
            LegendWidget(
                graphsManagerService: graphsManagerService,
                month: graphsScreenProvider.selectedDate),
            MonthChartWidget(
                graphsManagerService: graphsManagerService,
                month: graphsScreenProvider.selectedDate),
          ],
          staggeredTiles: [
            StaggeredTile.extent(4, 235.0),
            StaggeredTile.extent(2, 215.0),
            StaggeredTile.extent(2, 75.0),
            StaggeredTile.extent(2, 140.0),
            StaggeredTile.extent(4, 215.0),
          ],
        ),
      ),
    );
  }
}

class LegendWidget extends StatelessWidget {
  final GraphsManagerService graphsManagerService;
  final DateTime month;
  const LegendWidget(
      {@required this.graphsManagerService, @required this.month});

  @override
  Widget build(BuildContext context) {
    var list = graphsManagerService.getLegendsDatasByDate(month);
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: getAppCardStyle(
        child: Container(
          margin: EdgeInsets.all(20),
          child: list.isEmpty
              ? Center(child: Text("No Data"))
              : ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: graphsManagerService.getLegendsDatasByDate(month),
                ),
        ),
      ),
    );
  }
}

class MonthChartWidget extends StatelessWidget {
  final GraphsManagerService graphsManagerService;
  final DateTime month;

  MonthChartWidget({
    @required this.graphsManagerService,
    @required this.month,
  });

  @override
  Widget build(BuildContext context) {
    var list = graphsManagerService.getMonthChartDatasByDate(month);
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: getAppCardStyle(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: list.isEmpty
                    ? Center(child: Text("No Data"))
                    : MonthLineChart(graphsManagerService
                        .getMonthChartDatasByDate(month)))));
  }
}

class MonthSelectorWidget extends StatelessWidget {
  const MonthSelectorWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final graphsScreenProvider = context.read<GraphsScreenProvider>();
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: getAppCardStyle(
        // color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: TextButton(
            child: Text(
              getFormatedyyyyMMMDate(graphsScreenProvider.selectedDate),
              style: Theme.of(context).textTheme.headline3.copyWith(
                  decoration: TextDecoration.underline, color: Colors.blue),
            ),
            onPressed: () {
              showMonthPicker(
                okText: "Confirm",
                context: context,
                // firstDate: DateTime(DateTime.now().year - 1, 5),
                // lastDate: DateTime(DateTime.now().year + 1, 9),
                initialDate: graphsScreenProvider.selectedDate,
                //locale: Locale("es"),
              ).then((date) {
                if (date != null && date != graphsScreenProvider.selectedDate) {
                  graphsScreenProvider.changeSelectedDate(date);
                }
                // if (date != null) {
                //   setState(() {
                //     selectedDate = date;
                //   });
                // }
              });
            },

            //SizedBox(
            //  width: 20,
            //),
          ),
        ),
      ),
    );
  }
}

class PieChart extends StatelessWidget {
  final GraphsManagerService graphsManagerService;
  final DateTime month;
  const PieChart({@required this.graphsManagerService, @required this.month});

  @override
  Widget build(BuildContext context) {
    var list = graphsManagerService.getPieChartDatasByDate(month);

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: getAppCardStyle(
        child: Center(
            child: list.isEmpty
                ? Text("No Data")
                : PieCHart(graphsManagerService.getPieChartDatasByDate(month))),
      ),
    );
  }
}

class LastFourMonthChartWidget extends StatelessWidget {
  final GraphsManagerService graphsManagerService;
  final DateTime month;

  LastFourMonthChartWidget({
    Key key,
    @required this.graphsManagerService,
    @required this.month,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: getAppCardStyle(
        child: Padding(
            padding: EdgeInsets.all(5),
            child: ComboChart(
                graphsManagerService.getPreviousMonthsDatasByDate(month))),
      ),
    );
  }
}
