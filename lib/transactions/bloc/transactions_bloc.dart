import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:pw_flutter/helper/models/models.dart';
import 'package:pw_flutter/repositories/transactions_repository/transactions_repository.dart';

part 'transactions_state.dart';
part 'transactions_event.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc({
    required TransactionsRepository transactionsRepository
  }) : _transactionsRepository = transactionsRepository,
       super(const TransactionsState());

  final TransactionsRepository _transactionsRepository;

  @override
  Stream<TransactionsState> mapEventToState(TransactionsEvent event) async* {
    if (event is CreateTransaction) {
      yield* _sendMoney(event, state);
    } else if (event is GetTransactions) {
      yield* _getTransactions(event, state);
    }
  }

  Stream<TransactionsState> _sendMoney(CreateTransaction event, TransactionsState state) async* {
    yield state.copyWith(isLoading: true, hasError: false);

    try {
      await _transactionsRepository.createTransaction(event.name, event.amount);
      final transactions = await _transactionsRepository.getTransactions();

      yield state.copyWith(transactions: transactions, isLoading: false);
    } catch (err) {
      yield state.copyWith(isLoading: false, hasError: true);
    }
  }

  Stream<TransactionsState> _getTransactions(GetTransactions event, TransactionsState state) async* {
    yield state.copyWith(isLoading: true, hasError: false);

    try {
      final transactions = await _transactionsRepository.getTransactions();

      yield state.copyWith(transactions: transactions, isLoading: false);
    } catch (err) {
      yield state.copyWith(isLoading: false, hasError: true);
    }
  }
}
