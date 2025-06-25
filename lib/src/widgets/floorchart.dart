import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FloorChart extends StatelessWidget {
   FloorChart({super.key,required this.provider});
  late List<_ChartData> dataIn,dataOut;
  late TooltipBehavior _tooltip;
  dynamic provider;


  @override
  Widget build(BuildContext context) {
    
    double maximum  = max(provider.first_inn.toDouble(),max(provider.second_inn.toDouble(),
        max(provider.third_inn.toDouble(), max(provider.fourth_inn.toDouble(),
            max( provider.fifth_inn.toDouble(), max(provider.first_out.toDouble(),
            max(provider.second_out.toDouble(), max(provider.third_out.toDouble(),
            max(provider.fourth_out.toDouble(), provider.fifth_out.toDouble())))))))));

    dataIn = [
      _ChartData('1st', provider.first_inn.toDouble()),
      _ChartData('2nd', provider.second_inn.toDouble()),
      _ChartData('3rd', provider.third_inn.toDouble()),
      _ChartData('4th', provider.fourth_inn.toDouble()),
      _ChartData('5th', provider.fifth_inn.toDouble()),
    ];
    dataOut = [
      _ChartData('1st', provider.first_out.toDouble()),
      _ChartData('2nd', provider.second_out.toDouble()),
      _ChartData('3rd', provider.third_out.toDouble()),
      _ChartData('4th', provider.fourth_out.toDouble()),
      _ChartData('5th', provider.fifth_out.toDouble()),
    ];
    _tooltip = TooltipBehavior(enable: true);

    return Card(
      child: Container( width: 400,
        child: SfCartesianChart( title: const ChartTitle(text: 'Visitors by floor',textStyle: TextStyle(fontWeight: FontWeight.bold)),
            primaryXAxis: CategoryAxis(interval: 1,labelPlacement: LabelPlacement.betweenTicks,),
            primaryYAxis: NumericAxis(minimum: 0, maximum: maximum, interval: 1),
           legend: Legend(isVisible: true),
            tooltipBehavior: _tooltip,
            series: <CartesianSeries<_ChartData, String>>[
              ColumnSeries<_ChartData, String>(
                  dataSource: dataIn,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'In',
                  color: Colors.green,
             ),

              ColumnSeries<_ChartData, String>(
                  dataSource: dataOut,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Out',
                  color: Colors.orange),

            ]),
      ),
    );
  }

}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}