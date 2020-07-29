import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../transaction.dart';

class TransactionCards extends StatelessWidget {

  final List<Transaction> transactions;

  const TransactionCards({Key key, this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: 300,
        child: new ListView.builder(
          itemBuilder: (lstContext, index) {
            return Card(
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Theme
                                .of(context)
                                .accentColor)),
                        child: Text("\$${transactions[index].price.toString()}",
                            style: Theme
                            .of(context)
                            .textTheme.subtitle1.copyWith(fontSize: 20,fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors
                                .transparent)),
                        padding: EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              transactions[index].title,
                              style: Theme
                            .of(context)
                            .textTheme.subtitle2.copyWith(fontSize: 18,fontWeight: FontWeight.bold),
                            ),
                            Text(transactions[index].details,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                DateFormat()
                                    .add_yMMMEd()
                                    .add_jm()
                                    .format(transactions[index].date),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: this.transactions.length,

        ));
  }
}
