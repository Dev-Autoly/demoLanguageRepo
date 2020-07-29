import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:qrlisttracker/charts/flutterCharts/pollution.dart';

import 'file:///D:/FlutterProjects/qr_list_tracker/lib/charts/flutterCharts/pie_chart.dart';

import 'flutterCharts/bar_chart.dart';
import 'flutterCharts/line_chart.dart';
import 'flutterCharts/sales.dart';
import 'flutterCharts/task.dart';

class FlutterChartsExample extends StatefulWidget {
  @override
  _FlutterChartsExampleState createState() => _FlutterChartsExampleState();
}

class _FlutterChartsExampleState extends State<FlutterChartsExample> {
  List<charts.Series<Task,String>> _seriesPieData;
  List<charts.Series<Pollution,String>> _seriesBarData;
  List<charts.Series<Sales,int>> _seriesLineData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesBarData = List<charts.Series<Pollution,String>>();
    _seriesPieData = List<charts.Series<Task,String>>();
    _seriesLineData = List<charts.Series<Sales,int>>();
    _generateData();
  }
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(

        appBar: AppBar(
          title: Text('Flutter Charts Examples'),
         bottom: TabBar(

           indicatorColor: Theme.of(context).primaryColor,
           tabs: <Widget>[
             Tab(icon: Icon(Icons.pie_chart),),
             Tab(icon: Icon(Icons.insert_chart),),
             Tab(icon: Icon(Icons.multiline_chart)),
           ],
         ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Go Back"),
          icon: Icon(Icons.arrow_back),
          onPressed: (){Navigator.pop(context);},
        ),
        body: TabBarView(

          children: <Widget>[
                    //SIMPLE CHARTS
                    //SimpleBarChart(),
                    //GRADIENT LINE CHART
                    PieChartExample(seriesPieData: _seriesPieData),
                    //SIMPLE FILL CHART


                   LineChartExample(seriesLineData: _seriesLineData,),
                    BarChartExample(seriesBarData: _seriesBarData)
                  ],
                ),
              ),
    );

  }

  void _generateData() {
    var data1 = [
      new Pollution( "USA", 1980, 50),
      new Pollution( "Canada", 1980, 20),
      new Pollution( "India", 1980, 60),

    ];
    var data2 = [
      new Pollution( "USA", 1990, 60),
      new Pollution( "Canada", 1990, 30),
      new Pollution( "India", 1990, 65),

    ];
    var data3 = [
      new Pollution( "USA", 2000, 75),
      new Pollution( "Canada", 2000, 50),
      new Pollution( "India", 2000, 88),

    ];

    var salesData = [
      new Sales(0,90),
      new Sales(1,40),
      new Sales(2,50),
      new Sales(3,60),
      new Sales(4,70),
      new Sales(5,90),
    ];

    var salesData1 = [
      new Sales(0,80),
      new Sales(1,50),
      new Sales(2,60),
      new Sales(3,70),
      new Sales(4,80),
      new Sales(5,90),
    ];
    var salesData2 = [

      new Sales(0,120),
      new Sales(1,60),
      new Sales(2,70),
      new Sales(3,80),
      new Sales(4,90),
      new Sales(5,100),

    ];



    var pieData = [
      new Task("All",90.10,Colors.red),
      new Task("Flutter",90.20,Colors.blue),
      new Task("No",30.10,Colors.green),
      new Task("Play",10.10,Colors.teal),
      new Task("Makes",50.10,Colors.purple),
      new Task("Moiz",60.10,Colors.grey),
      new Task("A",70.10,Colors.orange),
      new Task("Dull",80.10,Colors.lightBlue),
      new Task("Boy",9.5,Colors.amber),

    ];

    _seriesPieData.add(charts.Series(
      data: pieData,
      domainFn: (Task task,_)=> task.task,
      measureFn: (Task task,_)=>task.taskValue,
     colorFn: (Task task,_)=> charts.ColorUtil.fromDartColor(task.colorVal),
     id: "Daily Tasks",
     labelAccessorFn: (Task row,_)=>"${row.taskValue}"
    ),
    );

    _seriesBarData.add(charts.Series(
      domainFn: (Pollution pollution,_)=> pollution.place,
      measureFn: (Pollution pollution,_)=> pollution.quantity,
      fillPatternFn: (_, __)=> charts.FillPatternType.forwardHatch,
      fillColorFn: (Pollution pollution,_)=> charts.ColorUtil.fromDartColor(Colors.red),
      data: data1,
      id: "1980",
    ));
    _seriesBarData.add(charts.Series(
        domainFn: (Pollution pollution,_)=> pollution.place,
        measureFn: (Pollution pollution,_)=> pollution.quantity,
        fillPatternFn: (_, __)=> charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution,_)=> charts.ColorUtil.fromDartColor(Colors.blue),
        data: data2,
        id: "1990",
    ));
    _seriesBarData.add(charts.Series(
        domainFn: (Pollution pollution,_)=> pollution.place,
        measureFn: (Pollution pollution,_)=> pollution.quantity,
        fillPatternFn: (_, __)=> charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution,_)=> charts.ColorUtil.fromDartColor(Colors.green),
        data: data3,
        id: "2000",
    ));

    _seriesLineData.add(charts.Series(
      domainFn: (Sales sales,_)=> sales.yearVal,
      measureFn: (Sales sales,_)=> sales.salesVal,
      fillPatternFn: (_, __)=> charts.FillPatternType.solid,
      fillColorFn: (Sales sales,_)=> charts.ColorUtil.fromDartColor(Colors.red),
      data: salesData,
      id: "Sales Data",
    ));
    _seriesLineData.add(charts.Series(
      domainFn: (Sales sales,_)=> sales.yearVal,
      measureFn: (Sales sales,_)=> sales.salesVal,
      fillPatternFn: (_, __)=> charts.FillPatternType.solid,
      fillColorFn: (Sales sales,_)=> charts.ColorUtil.fromDartColor(Colors.blue),
      data: salesData,
      id: "Sales Data",
    ));
    _seriesLineData.add(charts.Series(
      domainFn: (Sales sales,_)=> sales.yearVal,
      measureFn: (Sales sales,_)=> sales.salesVal,
      fillPatternFn: (_, __)=> charts.FillPatternType.solid,
      fillColorFn: (Sales sales,_)=> charts.ColorUtil.fromDartColor(Colors.green),
      data: salesData,
      id: "Sales Data",
    ));
  }
}


class LineChartExample extends StatelessWidget {
  const LineChartExample({
    Key key,
    @required List<charts.Series<Sales, int>> seriesLineData
  }) : _seriesLineData = seriesLineData, super(key: key);

  final List<charts.Series<Sales, int>> _seriesLineData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text('Sales Data:'),
          Container(height: 600,width: double.infinity,
              child: LineChart(data: _seriesLineData)),
        ],
      ),
    );
  }
}


class BarChartExample extends StatelessWidget {
  const BarChartExample({
    Key key,
    @required List<charts.Series<Pollution, String>> seriesBarData
  }) : _seriesBarData = seriesBarData, super(key: key);

  final List<charts.Series<Pollution, String>> _seriesBarData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text('Pollution Level from 1980 - 2000:'),
          Container(height: 500,width: double.infinity,
              child: BarChart(data: _seriesBarData)),
        ],
      ),
    );
  }
}

class PieChartExample extends StatelessWidget {
  const PieChartExample({
    Key key,
    @required List<charts.Series<Task, String>> seriesPieData,
  }) : _seriesPieData = seriesPieData, super(key: key);

  final List<charts.Series<Task, String>> _seriesPieData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text('Time Spent on daily tasks:'),
          Container(height: 600,width: double.infinity,
              child: PieChart(data: _seriesPieData)),
        ],
      ),
    );
  }
}
