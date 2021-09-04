/// Example of an ordinal combo chart with two series rendered as bars, and a
/// third rendered as a line.
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_common/common.dart' as color;

//top chart
class ComboChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  ComboChart(this.seriesList, {this.animate});

  factory ComboChart.withSampleData() {
    return new ComboChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.OrdinalComboChart(
      seriesList,
      animate: animate,

      domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(

              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .fontSize
                      .toInt(), // size in Pts.
                  color: charts.MaterialPalette.black),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.black))),
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(
            // Tick and Label styling here.
            labelStyle: new charts.TextStyleSpec(
                fontSize: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .fontSize
                    .toInt(), // size in Pts.
                color: charts.MaterialPalette.black),
          ),
          showAxisLine: true,
          tickProviderSpec: new charts.BasicNumericTickProviderSpec(
            // Make sure we don't have values less than 1 as ticks
            // (ie: counts).

            desiredMinTickCount: 5,
            dataIsInWholeNumbers: true,
            // Fixed tick count to highlight the integer only behavior
            // generating ticks [0, 1, 2, 3, 4].
          )),
      // Configure the default renderer as a bar renderer.
      defaultRenderer: new charts.BarRendererConfig(
          groupingType: charts.BarGroupingType.grouped),
      // Custom renderer configuration for the line series. This will be used for
      // any series that does not define a rendererIdKey.
      customSeriesRenderers: [
        new charts.LineRendererConfig(
            strokeWidthPx: 2,
            // ID used to link series to this renderer.
            customRendererId: 'customLine')
      ],
      behaviors: [
        new charts.ChartTitle('Previous three months',
            titleStyleSpec: TextStyleSpec(
                fontSize:
                    Theme.of(context).textTheme.headline2.fontSize.toInt()),
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.end,
            // Set a larger inner padding than the default (10) to avoid
            // rendering the text too close to the top measure axis tick label.
            // The top tick label may extend upwards into the top margin region
            // if it is located at the top of the draw area.
            innerPadding: 10),
        // new charts.SlidingViewport(),
        new charts.LinePointHighlighter(
            showHorizontalFollowLine:
                charts.LinePointHighlighterFollowLineType.none,
            showVerticalFollowLine:
                charts.LinePointHighlighterFollowLineType.none),
        new charts.SelectNearest(
            eventTrigger: (charts.SelectionTrigger.tapAndDrag)),

        //new charts.SlidingViewport(),
        // A pan and zoom behavior helps demonstrate the sliding viewport
        // behavior by allowing the data visible in the viewport to be adjusted
        // dynamically.
        //new charts.PanAndZoomBehavior(),
      ],
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014.Jan', 200000),
      new OrdinalSales('2015.Jan', 250000),
      new OrdinalSales('2016.Jan', 100000),
      //  new OrdinalSales('2017.Jan', 175000),
    ];

    final tableSalesData = [
      new OrdinalSales('2014.Jan', -150000),
      new OrdinalSales('2015.Jan', -100000),
      new OrdinalSales('2016.Jan', -100000),
      // new OrdinalSales('2017.Jan', -81500),
    ];

    //TODO megtakarítás
    final mobileSalesData = [
      new OrdinalSales('2014.Jan', 10000),
      new OrdinalSales('2015.Jan', 150000),
      new OrdinalSales('2016.Jan', 200000),
      //  new OrdinalSales('2017.Jan', 1500000),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
          id: 'Desktop',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: desktopSalesData),
      new charts.Series<OrdinalSales, String>(
          id: 'Tablet',
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: tableSalesData),
      new charts.Series<OrdinalSales, String>(
          id: 'Mobile ',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: mobileSalesData)
        // Configure our custom line renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customLine'),
    ];
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

//pie chart
class PieCHart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PieCHart(this.seriesList, {this.animate});

  factory PieCHart.withSampleData(BuildContext context) {
    return new PieCHart(
      _createSampleData(context),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
        new charts.ArcLabelDecorator(
            labelPosition: charts.ArcLabelPosition.auto)
      ]),
    );
  }

  /// Create series list with one series
  static List<charts.Series<LinearSales, String>> _createSampleData(
      BuildContext context) {
    final data = [
      new LinearSales("Food", 100, Colors.amber),
      new LinearSales("Investment", 75, Colors.green),
      new LinearSales("Invoices", 25, Colors.cyan),
      new LinearSales("3", 5, Colors.pink),
      new LinearSales("4", 100, Colors.blue),
    ];

    return [
      new charts.Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales data, _) => data.category,
        measureFn: (LinearSales data, _) => data.sales,
        colorFn: (LinearSales data, __) =>
            charts.ColorUtil.fromDartColor(data.color),
        //outsideLabelStyleAccessorFn: (LinearSales data, _) =>
        //    new charts.TextStyleSpec(
        //        color: MaterialPalette.black,
        //        fontSize:
        //            Theme.of(context).textTheme.bodyText2.fontSize.toInt()),
        insideLabelStyleAccessorFn: (LinearSales data, _) =>
            new charts.TextStyleSpec(
                color: MaterialPalette.black,
                fontSize:
                    Theme.of(context).textTheme.bodyText2.fontSize.toInt()),
        labelAccessorFn: (LinearSales data, _) =>
            data.sales > 35 ? "${data.sales}%" : "",
        data: data,
      )
    ];
  }
}

class LinearSales {
  final String category;
  final int sales;
  final MaterialColor color;

  LinearSales(this.category, this.sales, this.color);
}

//mont line chart
class MonthLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  MonthLineChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory MonthLineChart.withSampleData() {
    return new MonthLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,

      domainAxis: new DateTimeAxisSpec(
        showAxisLine: true,
        renderSpec: new charts.SmallTickRendererSpec(
          // Tick and Label styling here.

          labelStyle: new charts.TextStyleSpec(
              fontSize: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .fontSize
                  .toInt(), // size in Pts.
              color: charts.MaterialPalette.black),
        ),
        //TODO a honap legalabb elso utolso középső datum látható legyen
        //tickProviderSpec:
        //    new StaticDateTimeTickProviderSpec([TickSpec(DateTime.now())])

        //axisLineStyle:
        //    new charts.LineStyleSpec(color: charts.MaterialPalette.black)),
      ),

      primaryMeasureAxis: new charts.NumericAxisSpec(
          showAxisLine: true,
          renderSpec: new charts.GridlineRendererSpec(
            // Tick and Label styling here.
            labelStyle: new charts.TextStyleSpec(
                fontSize: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .fontSize
                    .toInt(), // size in Pts.
                color: charts.MaterialPalette.black),
          ),
          tickProviderSpec: new charts.BasicNumericTickProviderSpec(
            // Make sure we don't have values less than 1 as ticks
            // (ie: counts).
            zeroBound: false,
            desiredMinTickCount: 5,
            dataIsInWholeNumbers: true,

            // // Fixed tick count to highlight the integer only behavior
            // generating ticks [0, 1, 2, 3, 4].
          )),
      // defaultRenderer: new charts.LineRendererConfig(),

      //  selectionModels: [
      //        new charts.SelectionModelConfig(
      //
      //          updatedListener: _onSelectionChanged,
      //          type: charts.SelectionModelType.info,
      //
      //        )
      //      ],

      behaviors: [
        new charts.LinePointHighlighter(
            showHorizontalFollowLine:
                charts.LinePointHighlighterFollowLineType.none,
            showVerticalFollowLine:
                charts.LinePointHighlighterFollowLineType.none),
        new charts.SelectNearest(
            eventTrigger: (charts.SelectionTrigger.tapAndDrag)),
//
        //  new charts.SlidingViewport(),
        //  // A pan and zoom behavior helps demonstrate the sliding viewport
        //  // behavior by allowing the data visible in the viewport to be adjusted
        //  // dynamically.
        //  new charts.PanAndZoomBehavior(),
      ],
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2017, 9, 1), 240000),
      new TimeSeriesSales(new DateTime(2017, 9, 3), 200000),
      new TimeSeriesSales(new DateTime(2017, 9, 5), 100000),
      new TimeSeriesSales(new DateTime(2017, 9, 10), -75000),
      new TimeSeriesSales(new DateTime(2017, 9, 15), 65000),
      new TimeSeriesSales(new DateTime(2017, 9, 23), 51000),
      new TimeSeriesSales(new DateTime(2017, 9, 24), 50000),
      new TimeSeriesSales(new DateTime(2017, 9, 25), -7500),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 1000),
      new TimeSeriesSales(new DateTime(2017, 9, 27), 750),
      new TimeSeriesSales(new DateTime(2017, 9, 28), 75000),
    ];

// Generate 2 shades of each color so that we can style the line segments.
    final red = charts.MaterialPalette.red.shadeDefault;
    final green = charts.MaterialPalette.green.shadeDefault;

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        seriesColor: green,
        colorFn: (TimeSeriesSales asd, __) =>
            asd.sales % 10000 == 0 ? green : red,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        areaColorFn: (TimeSeriesSales asd, __) =>
            asd.sales % 10000 == 0 ? green : red,
        data: data,
      )
    ];
  }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
