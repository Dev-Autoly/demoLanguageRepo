import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  final String label;
  final double spendingAmount;
  final double spendingTotalPercentage;

  ChartBar(this.label, this.spendingAmount, this.spendingTotalPercentage);

  @override
  Widget build(BuildContext context) {
    return Container(child:
    Column(children: <Widget>[
      Text("\$${spendingAmount.toStringAsFixed(0)}", style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18, fontWeight: FontWeight.w300),),
      SizedBox(height: 4,),
      Container(
        height: 60,
        width: 10, child: Stack(children: <Widget>[
        Container(decoration: BoxDecoration(
            color: Color.fromRGBO(220, 220, 220, 1),
            border: Border.all(color: Colors.grey, width: 1.0)),),
        FractionallySizedBox(heightFactor: spendingTotalPercentage,
          child: Container(decoration: BoxDecoration(color: Theme
              .of(context)
              .primaryColor),),)
      ],),
      ),
      SizedBox(height: 4,)
    ],),);
  }
}
