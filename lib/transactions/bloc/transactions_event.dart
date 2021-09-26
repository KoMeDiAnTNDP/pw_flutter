part of 'transactions_bloc.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object> get props => [];
}

class CreateTransaction extends TransactionsEvent {
  const CreateTransaction(this.name, this.amount);

  final String name;
  final double amount;

  @override
  List<Object> get props => [name, amount];
}

class GetTransactions extends TransactionsEvent {}
