import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:qrlisttracker/charts/flutterCharts/sales.dart';

class LineChart extends StatefulWidget {
  const LineChart({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List<charts.Series<Sales, int>> data;

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Expanded(
        child: charts.LineChart(
          widget.data,
          animate: true,
          defaultRenderer: new charts.LineRendererConfig(
            includeArea: true,
            stacked: true
          ),
          animationDuration: Duration(milliseconds: 2500),
          behaviors: [
            new charts.ChartTitle("Autoly Sales",
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
            new charts.ChartTitle("Years",
                behaviorPosition: charts.BehaviorPosition.bottom,
                titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
            new charts.ChartTitle("Title 3",
                behaviorPosition: charts.BehaviorPosition.end,
                titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
          ],
        ),
      ),
    );
  }
}
