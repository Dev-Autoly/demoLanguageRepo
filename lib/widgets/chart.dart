import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);
  
  List<Map<String, Object>>get groupedTransactionValues{
    return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for(int i =0 ; i < recentTransactions.length ; i++){

          if(recentTransactions[i].date.day == weekDay.day
            && recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) {
            totalSum += recentTransactions[i].price;

          }
      }


      return {"day": DateFormat.E().format(weekDay), "amount": totalSum};
    });
  }

  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children:
        groupedTransactionValues.map((data) {
          return ChartBar(data['data'], data['amount'], (data['amount'] as double)/totalSpending);
        }).toList(),
      )
      
    );
  }
}
