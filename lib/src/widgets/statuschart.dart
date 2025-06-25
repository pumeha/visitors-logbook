import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatusChart extends StatelessWidget {
   StatusChart({super.key,required this.inn,required this.out});
  late List<_ChartData> data;

   double inn;
   double out;
  //late TooltipBehavior _tooltip;

  @override
  Widget build(BuildContext context) {


    double total =  max(inn, out) ;


    data = [
      _ChartData('Total In', inn),
      _ChartData('Total Out', out),
    ];
    //_tooltip = TooltipBehavior(enable: true);

    return SfCartesianChart(
      title:ChartTitle(text: 'Visitors by Status',textStyle: TextStyle(fontWeight: FontWeight.bold)),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(minimum: 0, maximum: total, interval: 1),
      //  tooltipBehavior: _tooltip,
        series: <CartesianSeries<_ChartData, String>>[
          ColumnSeries<_ChartData, String>(
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              //name: '',
              color: Colors.green),


        ]);
  }

}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
