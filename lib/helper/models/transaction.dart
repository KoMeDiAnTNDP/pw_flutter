import 'package:intl/intl.dart';
import 'package:equatable/equatable.dart';

import 'package:pw_flutter/helper/utils/utils.dart';

class Transaction extends Equatable {
  const Transaction({
    required this.id,
    required this.date,
    required this.name,
    required this.amount,
    required this.balance,
  });

  final int id;
  final DateTime date;
  final String name;
  final double amount;
  final double balance;

  @override
  List<Object> get props => [id, date, name, amount, balance];

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      date: DateFormat('MM/dd/yyyy, hh:mm:ss a').parse(json['date']),
      name: json['username'],
      amount: Utils.parseToDouble(json['amount']),
      balance: Utils.parseToDouble(json['balance']),
    );
  }
}