import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';

import 'package:pw_flutter/helper/models/models.dart';
import 'package:pw_flutter/helper/consts/consts.dart';
import 'package:pw_flutter/transactions/bloc/transactions_bloc.dart';
import 'package:pw_flutter/repositories/user_repository/user_repository.dart';
import 'package:pw_flutter/repositories/transactions_repository/transactions_repository.dart';

part 'send_money_event.dart';
part 'send_money_state.dart';

class SendMoneyBloc extends Bloc<SendMoneyEvent, SendMoneyState> {
  SendMoneyBloc({
    required SendMoneyState initialState,
    required TransactionsBloc transactionsBloc,
    required UserRepository userRepository,
    required TransactionsRepository transactionsRepository,
  }) : _transactionsBloc = transactionsBloc,
       _userRepository = userRepository,
       _transactionsRepository = transactionsRepository,
       super(initialState);

  final UserRepository _userRepository;
  final TransactionsBloc _transactionsBloc;
  final TransactionsRepository _transactionsRepository;

  @override
  Stream<Transition<SendMoneyEvent, SendMoneyState>> transformEvents(
    Stream<SendMoneyEvent> events,
    TransitionFunction<SendMoneyEvent, SendMoneyState> transitionFn
  ) {
    final nonDebounceStream = events
        .where((event) => event is! SendMoneyFindUser);

    final debounceStream = events
        .where((event) => event is SendMoneyFindUser)
        .debounceTime(DURATION);

    return MergeStream([nonDebounceStream, debounceStream])
        .flatMap(transitionFn);
  }

  @override
  Stream<SendMoneyState> mapEventToState(SendMoneyEvent event) async* {
    if (event is SendMoneyRecipientChanged) {
      yield _recipientChanged(event, state);

      if (event.shouldSearch && event.recipient.isNotEmpty) {
        add(SendMoneyFindUser(event.recipient));
      }
    } else if (event is SendMoneyAmountChanged) {
      yield _amountChanged(event, state);
    } else if (event is SendMoneyFindUser) {
      yield* _findUsers(event, state);
    } else if (event is SendMoneySubmitted) {
      yield* _submitted(event, state);
    }
  }

  SendMoneyState _recipientChanged(SendMoneyRecipientChanged event, SendMoneyState state) {
    final recipient = Name.dirty(event.recipient);

    return state.copyWith(
      recipient: recipient,
      status: Formz.validate([recipient, state.amount]),
    );
  }

  SendMoneyState _amountChanged(SendMoneyAmountChanged event, SendMoneyState state) {
    print('amountChanged ${event.amount}');
    final amount = Amount.dirty(balance: state.amount.balance, value: event.amount);
    print('amount $amount');

    return state.copyWith(
      amount: amount,
      status: Formz.validate([state.recipient, amount]),
    );
  }

  Stream<SendMoneyState> _findUsers(SendMoneyFindUser event, SendMoneyState state) async* {
    try {
      final foundUsers = await _userRepository.getFilteredUsers(event.name);

      yield state.copyWith(filteredUsers: foundUsers);
    } catch (err) {
      yield state.copyWith(filteredUsers: []);
    }
  }

  Stream<SendMoneyState> _submitted(SendMoneySubmitted event, SendMoneyState state) async* {
    final recipient = Name.dirty(state.recipient.value);
    final amount = Amount.dirty(balance: state.amount.balance, value: state.amount.value);

    yield state.copyWith(
      recipient: recipient,
      amount: amount,
      status: Formz.validate([recipient, amount]),
    );

    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);

      try {
        await _transactionsRepository.createTransaction(recipient.value, amount.value);

        yield state.copyWith(
          status: FormzStatus.submissionSuccess
        );

        _transactionsBloc.add(TransactionsGetTransactions());
      } catch (err) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
