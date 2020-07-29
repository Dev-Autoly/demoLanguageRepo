import 'package:flutter/cupertino.dart';

class Transaction {
  final String id, title, details;
  DateTime date;
  double price;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.details,
    @required this.date,
    @required this.price
  });
}
