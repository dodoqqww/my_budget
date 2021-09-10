import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:my_budget/providers/graphs_screen_providers.dart';
import 'package:my_budget/ui/widgets/chart_widgets.dart';
import 'package:my_budget/ui/widgets/legend_widget.dart';
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
            LastFourMonthChartWidget(),
            PieChart(),
            MonthSelectorWidget(),
            LegendWidget(),
            MonthChartWidget(),
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
  const LegendWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: getAppCardStyle(
        child: Container(
          margin: EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              MyLegendWidget(text: "Investment", color: Colors.amber),
              MyLegendWidget(text: "Food", color: Colors.red),
              MyLegendWidget(text: "Car", color: Colors.green),
              MyLegendWidget(text: "legendtest", color: Colors.amber),
              MyLegendWidget(text: "legendtest", color: Colors.amber),
              MyLegendWidget(text: "legendtest", color: Colors.amber),
              MyLegendWidget(text: "legendtest", color: Colors.amber),
              MyLegendWidget(text: "legendtest", color: Colors.amber),
            ],
          ),
        ),
      ),
    );
  }
}

class MonthChartWidget extends StatelessWidget {
  const MonthChartWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: getAppCardStyle(
            child: Padding(
                padding: EdgeInsets.all(5),
                child: MonthLineChart.withSampleData())));
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
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: TextButton(
            child: Text(
              getFormatedyyyyMMMDate(graphsScreenProvider.selectedDate),
              style: Theme.of(context).textTheme.headline3.copyWith(
                  decoration: TextDecoration.underline, color: Colors.blue),
            ),
            onPressed: () {
              // TODO if cancel picker then error
              showMonthPicker(
                okText: "Confirm",
                context: context,
                // firstDate: DateTime(DateTime.now().year - 1, 5),
                // lastDate: DateTime(DateTime.now().year + 1, 9),
                initialDate: DateTime.now(),
                //locale: Locale("es"),
              ).then((date) {
                graphsScreenProvider.changeSelectedDate(date);
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
  const PieChart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: getAppCardStyle(
        child: Center(child: PieCHart.withSampleData(context)),
      ),
    );
  }
}

class LastFourMonthChartWidget extends StatelessWidget {
  const LastFourMonthChartWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: getAppCardStyle(
        child: Padding(
            padding: EdgeInsets.all(5), child: ComboChart.withSampleData()),
      ),
    );
  }
}
