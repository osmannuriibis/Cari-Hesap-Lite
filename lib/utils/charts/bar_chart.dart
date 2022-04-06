import 'package:charts_flutter/flutter.dart' as C;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../print.dart';
import 'charts_utils.dart';
/* 
class MyBarChart extends StatelessWidget {
  const MyBarChart({
    Key? key,
    required this.chartSpec,
  }) : super(key: key);

  final ChartSpec chartSpec;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: C.BarChart(
        chartSpec.seriesList,

        behaviors: chartSpec.behaviors,
        //  barRendererDecorator: C.BarLabelDecorator(),
        // userManagedState: C.UserManagedState(),
       // barGroupingType: C.BarGroupingType.grouped,
       
        defaultRenderer: C.BarRendererConfig(
          cornerStrategy:C.ConstCornerStrategy(5) ,

            maxBarWidthPx: 30, minBarLengthPx: 10),
        selectionModels: [
          C.SelectionModelConfig(
            /*    changedListener: (model) {
              bas((model.selectedDatum.first.datum as ChartDeneme).adi);
            }, */
            type: C.SelectionModelType.action,
            updatedListener: (model) {
              if (model.selectedDatum.isNotEmpty)
                bas(model.selectedDatum.first.datum.yasi);
            },
          )
        ],
        domainAxis: C.OrdinalAxisSpec(
            renderSpec: C.SmallTickRendererSpec(
                labelAnchor: C.TickLabelAnchor.centered,
                labelJustification: C.TickLabelJustification.outside,
                //labelStyle: C.TextStyleSpec(),
                lineStyle: C.LineStyleSpec(
                  thickness: 5,
                ),
                tickLengthPx: 5,
                labelRotation: chartSpec.labelRotation ,
                minimumPaddingBetweenLabelsPx: 15)),
        layoutConfig: C.LayoutConfig(
            leftMarginSpec: C.MarginSpec.defaultSpec,
            topMarginSpec: C.MarginSpec.fixedPixel(20),
            rightMarginSpec: C.MarginSpec.defaultSpec,
            bottomMarginSpec: C.MarginSpec.defaultSpec),
        /**/
        primaryMeasureAxis: C.NumericAxisSpec(
            tickProviderSpec: C.BasicNumericTickProviderSpec(
              desiredMinTickCount: chartSpec.prMinTickCount,
              desiredMaxTickCount: chartSpec.prMaxTickCount,
            ),
            tickFormatterSpec: C.BasicNumericTickFormatterSpec.fromNumberFormat(
                NumberFormat.simpleCurrency(name: chartSpec.yBirim))),
      ),
    );
  }
} */
