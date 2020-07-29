import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:qrlisttracker/charts/flutterCharts/task.dart';

class PieChart extends StatefulWidget {
  const PieChart({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List<charts.Series<Task, String>> data;

  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Expanded(
        child: charts.PieChart(widget.data,

        animate: true,
        animationDuration: Duration(seconds: 5),
        behaviors: [
          new charts.DatumLegend(
              outsideJustification: charts.OutsideJustification.endDrawArea,
              horizontalFirst: false,
              desiredMaxRows: 2,
              cellPadding: new EdgeInsets.only(right: 4, bottom: 4),
              entryTextStyle: charts.TextStyleSpec(color: charts.MaterialPalette.purple.shadeDefault,
              fontFamily: 'OpenSans',
                fontSize: 10
              ),

          )
        ],
        defaultRenderer: new charts.ArcRendererConfig(
          arcWidth: 100,
          arcRendererDecorators: [
            new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.auto
            )
          ]
        ),
      ),

      ),
    );
  }
}
