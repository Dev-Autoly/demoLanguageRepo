import 'package:flutter/material.dart';

import './new_transaction.dart';
import './transaction_cards.dart';
import '../transaction.dart';
import 'chart.dart';

class UserTransaction extends StatefulWidget {
  UserTransaction({Key key}) : super(key: key);

  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {

  static var now = DateTime.now();
  final List<Transaction> transactions = [
    Transaction(
        id: "0",
        title: "New Shoes",
        details: "Getting new shoes data",
        date: DateTime.now().subtract(new Duration(days: 2)),
        price: 10.12),
    Transaction(
        id: "1",
        title: "New Glasses",
        details: "Getting new glasses data",
        date: DateTime.now(),
        price: 12.21),
    Transaction(
        id: "2",
        title: "New Hat",
        details: "Getting new hat data",
        date: DateTime.now(),
        price: 13.32),
    Transaction(
        id: "3",
        title: "New Macbook",
        details: "Getting new macbook data",
        date: DateTime.now().subtract(new Duration(days: 6)),
        price: 210.21),
    Transaction(
        id: "4",
        title: "New Keyboard",
        details: "Getting new keyboard data",
        date: DateTime.now().subtract(new Duration(days: 4)),
        price: 129.99),
    Transaction(
        id: "5",
        title: "New Mouse",
        details: "Getting new mouse data",
        date: DateTime.now().subtract(new Duration(days: 2)),
        price: 59.99),
    Transaction(
        id: "6",
        title: "New Speakers",
        details: "Getting new speakers data",
        date: DateTime.now().subtract(new Duration(days: 3)),
        price: 60.99)
  ];

  void _addNewTransaction(String title, String details, double price) {
    final _trans = Transaction(
        title: title,
        details: details,
        price: price,
        date: DateTime.now(),
        id: transactions.length.toString());

    setState(() {
      transactions.add(_trans);
    });
  }

  List<Transaction> get _recentTransactions {
    return this.transactions.where((element) {
        return element.date.isAfter(
        DateTime.now().subtract(
        Duration(days: 7)
    ));
  }
    ).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Chart(_recentTransactions),
        NewTransaction(this._addNewTransaction),
        TransactionCards(
          transactions: transactions,
        ),
      ],
    );
  }
}
