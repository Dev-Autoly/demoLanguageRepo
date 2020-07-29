import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class SparklineExamples extends StatelessWidget {
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SparkLine Examples'),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                //SIMPLE CHARTS
                simpleCharts(data: data),
                //GRADIENT LINE CHART
                simplePointsCharts(data: data,),
                //SIMPLE FILL CHART
                simpleFillCharts(data: data,),


                RaisedButton(child: Text("Go Back"),onPressed: (){Navigator.pop(context);},)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class simpleCharts extends StatelessWidget {
  const simpleCharts({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List<double> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          child: Column(
            children: <Widget>[
              Text("Simple Example",textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 20,fontFamily: 'OpenSans'),),
              Container(margin: EdgeInsets.all(15),
                width: double.infinity,
                height: 150.0,
                child: new Sparkline(
                  data: data,
                ),
              ),
            ],
          ),
          elevation: 10,
        ),
        Card(
          child: Column(
            children: <Widget>[
              Text("Simple Gradient Example",textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 20,fontFamily: 'OpenSans'),),
              Container(margin: EdgeInsets.all(15),
                width: double.infinity,
                height: 150.0,
                child: new Sparkline(
                  data: data,
                  lineWidth: 10.0,
                  lineGradient: new LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.purple[800], Colors.purple[200]],
                  ),
                ),
              )],
          ),
          elevation: 10,
        )
      ],
    );
  }
}
class simplePointsCharts extends StatelessWidget {
  const simplePointsCharts({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List<double> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          child: Column(
            children: <Widget>[
              Text("Simple Point End",textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 20,fontFamily: 'OpenSans'),),
              Container(margin: EdgeInsets.all(15),
                width: double.infinity,
                height: 150.0,
                child: new Sparkline(
                  data: data,
                  pointsMode: PointsMode.last,
                  pointSize: 8.0,
                  pointColor: Colors.amber,
                ),
              ),
            ],
          ),
          elevation: 10,
        ),
        Card(
          child: Column(
            children: <Widget>[
              Text("Simple Line Dotted",textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 20,fontFamily: 'OpenSans'),),
              Container(margin: EdgeInsets.all(15),
                width: double.infinity,
                height: 150.0,
                child: new Sparkline(
                  data: data,
                  pointsMode: PointsMode.all,
                  lineWidth: 3,
                  pointSize: 10.0,
                  pointColor: Colors.purple,
                ),
              )],
          ),
          elevation: 10,
        )
      ],
    );
  }
}
class simpleFillCharts extends StatelessWidget {
  const simpleFillCharts({
    Key key,
    @required this.data,
  }) : super(key: key);

  final List<double> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          child: Column(
            children: <Widget>[
              Text("Fill Color Above",textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 20,fontFamily: 'OpenSans'),),
              Container(margin: EdgeInsets.all(15),
                width: double.infinity,
                height: 150.0,
                child: new Sparkline(
                  data: data,
                  fillMode: FillMode.below,
                  fillColor: Colors.purple[200],
                ),
              ),
            ],
          ),
          elevation: 10,
        ),
        Card(
          child: Column(
            children: <Widget>[
              Text("Fill Color Above",textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 20,fontFamily: 'OpenSans'),),
              Container(margin: EdgeInsets.all(15),
                width: double.infinity,
                height: 150.0,
                child: new Sparkline(
                  data: data,
                  fillMode: FillMode.above,
                  fillColor: Colors.purple[200],
                ),
              )],
          ),
          elevation: 10,
        ),
        Card(
          child: Column(
            children: <Widget>[
              Text("Fill Color Gradient Bellow",textAlign: TextAlign.center,style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 20,fontFamily: 'OpenSans'),),
              Container(margin: EdgeInsets.all(15),
                width: double.infinity,
                height: 150.0,
                child: new Sparkline(
                  data: data,
                  fillMode: FillMode.below,
                  fillGradient: new LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.purple[800], Colors.purple[200]],
                  ),
                ),
              )],
          ),
          elevation: 10,
        )
      ],
    );
  }
}