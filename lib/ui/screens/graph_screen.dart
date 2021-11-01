import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:my_budget/providers/graphs_screen_providers.dart';
import 'package:my_budget/ui/widgets/chart_widgets.dart';
import 'package:my_budget/utils/util_methods.dart';
import './/ui/common/style.dart';
import 'package:provider/provider.dart';

class GraphScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("GraphScreen build()");
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
            LastFourMonthChartWidget(provider: graphsScreenProvider),
            PieChart(provider: graphsScreenProvider),
            MonthSelectorWidget(),
            LegendWidget(provider: graphsScreenProvider),
            MonthChartWidget(provider: graphsScreenProvider),
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
  final GraphsScreenProvider provider;
  const LegendWidget({@required this.provider});

  @override
  Widget build(BuildContext context) {
    print("LegendWidget build()");
    var list = provider.getLegendsDatasByDate();
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
                  children: list,
                ),
        ),
      ),
    );
  }
}

class MonthChartWidget extends StatelessWidget {
  final GraphsScreenProvider provider;

  MonthChartWidget({
    @required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    print("MonthChartWidget build()");
    var list = provider.getMonthChartDatasByDate();
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: getAppCardStyle(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: list.isEmpty
                    ? Center(child: Text("No Data"))
                    : MonthLineChart(list))));
  }
}

class MonthSelectorWidget extends StatelessWidget {
  const MonthSelectorWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final graphsScreenProvider = context.read<GraphsScreenProvider>();
    DateTime selectedDate = graphsScreenProvider.selectedDate;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: getAppCardStyle(
        // color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: TextButton(
            child: Text(
              getFormatedyyyyMMMDate(selectedDate),
              style: Theme.of(context).textTheme.headline3.copyWith(
                  decoration: TextDecoration.underline, color: Colors.blue),
            ),
            onPressed: () {
              showMonthPicker(
                okText: "Confirm",
                context: context,
                // firstDate: DateTime(DateTime.now().year - 1, 5),
                // lastDate: DateTime(DateTime.now().year + 1, 9),
                initialDate: selectedDate,
                //locale: Locale("es"),
              ).then((date) {
                if (date != null && date != selectedDate) {
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
  final GraphsScreenProvider provider;
  const PieChart({@required this.provider});

  @override
  Widget build(BuildContext context) {
    print("PieChart build()");
    var list = provider.getPieChartDatasByDate();

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: getAppCardStyle(
        child: Center(child: list.isEmpty ? Text("No Data") : PieCHart(list)),
      ),
    );
  }
}

class LastFourMonthChartWidget extends StatelessWidget {
  final GraphsScreenProvider provider;

  LastFourMonthChartWidget({
    Key key,
    @required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("LastFourMonthChartWidget build()");
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: getAppCardStyle(
        child: Padding(
            padding: EdgeInsets.all(5),
            child: ComboChart(provider.getPreviousMonthsDatasByDate())),
      ),
    );
  }
}
