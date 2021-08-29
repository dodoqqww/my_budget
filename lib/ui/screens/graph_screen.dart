import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
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
          //mainAxisSpacing: 1,
          //mainAxisSpacing: 4,
          children: <Widget>[
            LastFourMonthChartWidget(),
            PieChart(),
            MonthSelectorWidget(),
            CategoryListWidget(),
            MonthChartWidget(),
          ],
          staggeredTiles: [
            StaggeredTile.extent(4, 240.0),
            StaggeredTile.extent(2, 235.0),
            StaggeredTile.extent(2, 75.0),
            StaggeredTile.extent(2, 160.0),
            StaggeredTile.extent(4, 200.0),
          ],
        ),
      ),
    );
  }
}

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({
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
              legendWidget("Investment", Colors.amber),
              legendWidget("Food", Colors.red),
              legendWidget("Car", Colors.green),
              legendWidget("legendtest", Colors.amber),
              legendWidget("legendtest", Colors.amber),
              legendWidget("legendtest", Colors.amber),
              legendWidget("legendtest", Colors.amber),
              legendWidget("legendtest", Colors.amber),
            ],
          ),
        ),
      ),
    );
  }

  Widget legendWidget(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.circle,
            color: color,
            size: 20,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          )
        ],
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
                child: SimpleTimeSeriesChart.withSampleData())));
  }
}

class MonthSelectorWidget extends StatelessWidget {
  const MonthSelectorWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: getAppCardStyle(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //TODO picker mint frequencynél
              Text(
                "2021.Aug",
                style: TextStyle(
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
              IconButton(
                  onPressed: () {
                    showMonthPicker(
                      okText: "Confirm",
                      context: context,
                      // firstDate: DateTime(DateTime.now().year - 1, 5),
                      // lastDate: DateTime(DateTime.now().year + 1, 9),
                      initialDate: DateTime.now(),
                      //locale: Locale("es"),
                    ).then((date) {
                      // if (date != null) {
                      //   setState(() {
                      //     selectedDate = date;
                      //   });
                      // }
                    });
                  },
                  icon: Icon(
                    Icons.date_range,
                    color: Colors.blue,
                  ))
              //SizedBox(
              //  width: 20,
              //),
            ],
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
        child: Center(child: DatumLegendOptions.withSampleData()),
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
            padding: EdgeInsets.all(5),
            child: OrdinalComboBarLineChart.withSampleData()),
      ),
    );
  }
}
