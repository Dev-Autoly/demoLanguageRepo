import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:qrlisttracker/charts/flutterCharts/pollution.dart';

class BarChart extends StatefulWidget {
  const BarChart({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List<charts.Series<Pollution, String>> data;

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Expanded(
        child: charts.BarChart(
          widget.data,
          animate: true,
          animationDuration: Duration(milliseconds: 2500),
          barGroupingType: charts.BarGroupingType.grouped,

        ),
      ),
    );
  }
}
