/// Example of an ordinal combo chart with two series rendered as bars, and a
/// third rendered as a line.
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class OrdinalComboBarLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  OrdinalComboBarLineChart(this.seriesList, {this.animate});

  factory OrdinalComboBarLineChart.withSampleData() {
    return new OrdinalComboBarLineChart(
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
      primaryMeasureAxis: new charts.NumericAxisSpec(
          showAxisLine: true,
          tickProviderSpec: new charts.BasicNumericTickProviderSpec(
            // Make sure we don't have values less than 1 as ticks
            // (ie: counts).

            desiredMinTickCount: 4,
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
        new charts.ChartTitle('Last 4 months',
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.middle,
            // Set a larger inner padding than the default (10) to avoid
            // rendering the text too close to the top measure axis tick label.
            // The top tick label may extend upwards into the top margin region
            // if it is located at the top of the draw area.
            innerPadding: 5),
        // new charts.SlidingViewport(),
        new charts.LinePointHighlighter(
            showHorizontalFollowLine:
                charts.LinePointHighlighterFollowLineType.none,
            showVerticalFollowLine:
                charts.LinePointHighlighterFollowLineType.nearest),
        new charts.SelectNearest(
            eventTrigger: (charts.SelectionTrigger.tapAndDrag)),

        new charts.SlidingViewport(),
        // A pan and zoom behavior helps demonstrate the sliding viewport
        // behavior by allowing the data visible in the viewport to be adjusted
        // dynamically.
        new charts.PanAndZoomBehavior(),
      ],
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014.Jan', 200000),
      new OrdinalSales('2015.Jan', 250000),
      new OrdinalSales('2016.Jan', 100000),
      new OrdinalSales('2017.Jan', 175000),
    ];

    final tableSalesData = [
      new OrdinalSales('2014.Jan', -150000),
      new OrdinalSales('2015.Jan', -100000),
      new OrdinalSales('2016.Jan', -100000),
      new OrdinalSales('2017.Jan', -81500),
    ];

    //TODO megtakarítás
    final mobileSalesData = [
      new OrdinalSales('2014.Jan', 10000),
      new OrdinalSales('2015.Jan', 150000),
      new OrdinalSales('2016.Jan', 200000),
      new OrdinalSales('2017.Jan', 1500000),
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

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}

class DatumLegendOptions extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DatumLegendOptions(this.seriesList, {this.animate});

  factory DatumLegendOptions.withSampleData() {
    return new DatumLegendOptions(
      _createSampleData(),
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

      // Add the legend behavior to the chart to turn on legends.
      // This example shows how to change the position and justification of
      // the legend, in addition to altering the max rows and padding.
      behaviors: [
        //new charts.ChartTitle('2021.August',
        //    behaviorPosition: charts.BehaviorPosition.top,
        //    titleOutsideJustification: charts.OutsideJustification.middle,
        //    // Set a larger inner padding than the default (10) to avoid
        //    // rendering the text too close to the top measure axis tick label.
        //    // The top tick label may extend upwards into the top margin region
        //    // if it is located at the top of the draw area.
        //    innerPadding: 5),
        new charts.DatumLegend(
          // Positions for "start" and "end" will be left and right respectively
          // for widgets with a build context that has directionality ltr.
          // For rtl, "start" and "end" will be right and left respectively.
          // Since this example has directionality of ltr, the legend is
          // positioned on the right side of the chart.
          position: charts.BehaviorPosition.end,
          // For a legend that is positioned on the left or right of the chart,
          // setting the justification for [endDrawArea] is aligned to the
          // bottom of the chart draw area.
          outsideJustification: charts.OutsideJustification.endDrawArea,
          // By default, if the position of the chart is on the left or right of
          // the chart, [horizontalFirst] is set to false. This means that the
          // legend entries will grow as new rows first instead of a new column.
          horizontalFirst: false,
          // By setting this value to 2, the legend entries will grow up to two
          // rows before adding a new column.
          desiredMaxRows: 10,
          // This defines the padding around each legend entry.
          cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
          // Render the legend entry text with custom styles.
          entryTextStyle: charts.TextStyleSpec(
              // color: charts.MaterialPalette.gray.shadeDefault,
              // fontFamily: 'Georgia',
              fontSize: 12),
        )
      ],
    );
  }

  /// Create series list with one series
  static List<charts.Series<LinearSales, String>> _createSampleData() {
    final data = [
      new LinearSales("Food", 100, charts.MaterialPalette.red.makeShades(5)[4]),
      new LinearSales("Investment", 75, MaterialPalette.blue.shadeDefault),
      new LinearSales("Invoices", 25, MaterialPalette.cyan.shadeDefault),
      new LinearSales("3", 5, MaterialPalette.green.shadeDefault),
      new LinearSales("4", 100, MaterialPalette.pink.shadeDefault),
      // new LinearSales("5", 75),
      // new LinearSales("6", 25),
      // new LinearSales("7", 5),
    ];

    return [
      new charts.Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales data, _) => data.category,
        measureFn: (LinearSales data, _) => data.sales,
        colorFn: (LinearSales data, __) => data.color,
        outsideLabelStyleAccessorFn: (LinearSales data, _) =>
            new charts.TextStyleSpec(color: MaterialPalette.black),
        insideLabelStyleAccessorFn: (LinearSales data, _) =>
            new charts.TextStyleSpec(color: MaterialPalette.black),
        labelAccessorFn: (LinearSales data, _) =>
            data.sales > 35 ? "${data.sales}%" : "",
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final String category;
  final int sales;
  final Color color;

  LinearSales(this.category, this.sales, this.color);
}

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  //_onSelectionChanged(charts.SelectionModel model) {
  //  final selectedDatum = model.selectedDatum;
//
  //  DateTime time;
  //  final measures = <String, num>{};
//
  //  // We get the model that updated with a list of [SeriesDatum] which is
  //  // simply a pair of series & datum.
  //  //
  //  // Walk the selection updating the measures map, storing off the sales and
  //  // series name for each selection point.
  //  if (selectedDatum.isNotEmpty) {
  //    time = selectedDatum.first.datum.time;
  //    selectedDatum.forEach((charts.SeriesDatum datumPair) {
  //      measures[datumPair.series.displayName] = datumPair.datum.sales;
  //    });
  //  }
//
  //  // Request a build.
  //  print("asd");
  //}

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,

      primaryMeasureAxis: new charts.NumericAxisSpec(
          showAxisLine: true,
          tickProviderSpec: new charts.BasicNumericTickProviderSpec(
            // Make sure we don't have values less than 1 as ticks
            // (ie: counts).
            zeroBound: false,
            desiredMinTickCount: 4,
            dataIsInWholeNumbers: true,

            // // Fixed tick count to highlight the integer only behavior
            // generating ticks [0, 1, 2, 3, 4].
          )),
      defaultRenderer: new charts.LineRendererConfig(),

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
                charts.LinePointHighlighterFollowLineType.nearest,
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
    final blue = charts.MaterialPalette.blue.shadeDefault;
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

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
