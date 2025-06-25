import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PurposeChart extends StatelessWidget {
  PurposeChart({super.key,required this.non,required this.research,
    required this.meeting,required this.contract,required this.technical});
  late List<_ChartData> data;
  double non,technical,contract,meeting,research;

  //late TooltipBehavior _tooltip;
  @override
  Widget build(BuildContext context) {

    double total = max(non, max(technical, max(contract, max(meeting, research))));
    data = [
      _ChartData('Non Official', non),
      _ChartData('Technical Support',technical),
      _ChartData('Contract', contract),
      _ChartData('Meeting', meeting),
      _ChartData('Research', research)
    ];

    //_tooltip = TooltipBehavior(enable: true);
    return SfCartesianChart(
      title: const ChartTitle(text: 'Visitors based on Purpose',textStyle: TextStyle(fontWeight: FontWeight.bold)),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(minimum: 0, maximum: total, interval: 1),
       // tooltipBehavior: _tooltip,
        series: <CartesianSeries<_ChartData, String>>[
          BarSeries<_ChartData, String>(
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              //name: '',
              color: Colors.green)
        ]);
  }

}
class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}