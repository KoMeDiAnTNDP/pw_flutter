import 'package:equatable/equatable.dart';

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
  final int amount;
  final int balance;

  @override
  List<Object> get props => [id, date, name, amount, balance];

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      date: json['date'],
      name: json['username'],
      amount: json['amount'],
      balance: json['balance'],
    );
  }
}