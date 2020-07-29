import 'package:flutter/material.dart';
import 'package:qrlisttracker/charts/flutter_charts_example.dart';
import 'package:qrlisttracker/charts/sparkline_examples.dart';

class AllCharts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[

        RaisedButton(child: Text("SparkLine Line Chart Plugin", style: TextStyle(fontSize: 20),),onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SparklineExamples(),
            ),
          );
        },),
        RaisedButton(child: Text("Flutter Charts Plugin",style: TextStyle(fontSize: 20),),onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FlutterChartsExample(),
            ),
          );
        },),
      ],),),
    );
  }
}


