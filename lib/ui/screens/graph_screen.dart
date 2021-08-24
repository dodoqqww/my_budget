import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_budget/ui/widgets/chart.dart';
import './/ui/common/style.dart';

class GraphScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("GraphScreen build()");
    return Scaffold(
      body: Container(
        //padding: EdgeInsets.all(10),
        child: StaggeredGridView.count(
          crossAxisCount: 4,
          //mainAxisSpacing: 4,
          //mainAxisSpacing: 4,
          children: <Widget>[
            ChartOne(),
            PieChart(),
            IncomeChart(),
            ExpenseChart(),
            ChartTwo(),
          ],
          staggeredTiles: [
            StaggeredTile.extent(4, 240.0),
            StaggeredTile.extent(3, 235.0),
            //StaggeredTile.extent(2, 200.0),
            StaggeredTile.extent(1, 235.0),
            StaggeredTile.extent(4, 200.0),
          ],
        ),
      ),
    );
  }
}

class ChartTwo extends StatelessWidget {
  const ChartTwo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: getAppCardStyle(
        child: Center(child: Text("5")),
      ),
    );
  }
}

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: getAppCardStyle(
        child: Padding(
            padding: EdgeInsets.all(5),
            child: DateTimeComboLinePointChart.withSampleData()),
      ),
    );
  }
}

class IncomeChart extends StatelessWidget {
  const IncomeChart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: getAppCardStyle(
        child: Center(child: Text("3Details")),
      ),
    );
  }
}

class PieChart extends StatelessWidget {
  const PieChart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: getAppCardStyle(
        child: Center(child: DatumLegendOptions.withSampleData()),
      ),
    );
  }
}

class ChartOne extends StatelessWidget {
  const ChartOne({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: getAppCardStyle(
        child: Padding(
            padding: EdgeInsets.all(5),
            child: OrdinalComboBarLineChart.withSampleData()),
      ),
    );
  }
}
