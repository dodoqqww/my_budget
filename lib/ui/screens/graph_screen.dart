import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
            StaggeredTile.extent(4, 250.0),
            StaggeredTile.extent(2, 250.0),
            StaggeredTile.extent(2, 125.0),
            StaggeredTile.extent(2, 125.0),
            StaggeredTile.extent(4, 250.0),
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
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 75),
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
      padding: const EdgeInsets.only(right: 10),
      child: getAppCardStyle(
        child: Center(child: Text("4")),
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
        child: Center(child: Text("3")),
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
        child: Center(child: Text("2")),
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
        child: Center(child: Text("1")),
      ),
    );
  }
}
