import 'package:charts_flutter/flutter.dart' as C;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'charts_utils.dart';






/* class MyLineChart extends StatelessWidget {
  final ChartSpec chartSpec;

  MyLineChart(this.chartSpec);

  @override
  Widget build(BuildContext context) {
    return C.TimeSeriesChart(
      chartSpec.seriesList,
      primaryMeasureAxis: C.NumericAxisSpec(
          tickFormatterSpec: C.BasicNumericTickFormatterSpec.fromNumberFormat(
              NumberFormat.simpleCurrency(name: chartSpec.yBirim))),
      domainAxis: C.DateTimeAxisSpec(
          tickFormatterSpec: C.AutoDateTimeTickFormatterSpec(
        month: C.TimeFormatterSpec(format: "MMM"),
      )),
      animate: true,
      animationDuration: Duration(seconds: 1),
    );
  }
} */
