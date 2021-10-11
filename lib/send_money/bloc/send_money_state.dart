part of 'send_money_bloc.dart';

class SendMoneyState extends Equatable {
  SendMoneyState({
    required double balance,
    Amount? amount,
    this.recipient = const Name.pure(),
    this.status = FormzStatus.pure,
    this.filteredUsers = const [],
  }) : _balance = balance, amount = Amount.pure(balance: balance);

  final Amount amount;
  final Name recipient;
  final FormzStatus status;
  final List<FilteredUser> filteredUsers;
  final double _balance;

  @override
  List<Object> get props => [amount, recipient, status, filteredUsers];

  SendMoneyState copyWith({
    Amount? amount,
    Name? recipient,
    FormzStatus? status,
    List<FilteredUser>? filteredUsers,
  }) {
    return SendMoneyState(
      amount: amount ?? this.amount,
      recipient: recipient ?? this.recipient,
      status: status ?? this.status,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      balance: _balance,
    );
  }
}
