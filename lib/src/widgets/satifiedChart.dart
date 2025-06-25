import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SatifiedChart extends StatelessWidget {
  SatifiedChart({super.key, required this.five,required this.four,
    required this.three,required this.two,required this.one});
  late List<_ChartData> data;
  double five,four,three,two,one;

  //late TooltipBehavior _tooltip;
  @override
  Widget build(BuildContext context) {

    double total = max(one, max(two, max(three, max(four, five))));
    data = [
      _ChartData('Strongly Not Satisfied', five),
      _ChartData('Not Satisfied', four),
      _ChartData('Indifference', three),
      _ChartData('Satisfied',two),
      _ChartData('Strongly Satisfied', one)
    ];

    //_tooltip = TooltipBehavior(enable: true);
    return SfCartesianChart(
        title: const ChartTitle(text: 'Visitors satisfied with our services',textStyle: TextStyle(fontWeight: FontWeight.bold)),
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