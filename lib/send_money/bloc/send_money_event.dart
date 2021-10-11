part of 'send_money_bloc.dart';

abstract class SendMoneyEvent extends Equatable {
  const SendMoneyEvent();

  @override
  List<Object> get props => [];
}

class SendMoneyRecipientChanged extends SendMoneyEvent {
  const SendMoneyRecipientChanged(this.recipient, { this.shouldSearch = true });

  final String recipient;
  final bool shouldSearch;

  @override
  List<Object> get props => [recipient, shouldSearch];
}

class SendMoneyAmountChanged extends SendMoneyEvent {
  const SendMoneyAmountChanged(this.amount);

  final double amount;

  @override
  List<Object> get props => [amount];
}

class SendMoneyFindUser extends SendMoneyEvent {
  const SendMoneyFindUser(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class SendMoneySubmitted extends SendMoneyEvent {}
