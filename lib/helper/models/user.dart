import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.name,
    this.email,
    this.balance
  });

  final int id;
  final String? name;
  final String? email;
  final double? balance;


  static const empty = User(id: -1);

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, name, email, balance];

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      balance: json['balance']
    );
  }
}
