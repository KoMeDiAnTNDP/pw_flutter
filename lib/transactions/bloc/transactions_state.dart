part of 'transactions_bloc.dart';

class TransactionsState extends Equatable {
  const TransactionsState({
    this.transactions = const [],
    this.isLoading = false,
    this.hasError = false,
  });

  final List<Transaction> transactions;
  final bool isLoading;
  final bool hasError;

  @override
  List<Object?> get props => [transactions, isLoading, hasError];

  TransactionsState copyWith({
    List<Transaction>? transactions,
    bool? isLoading,
    bool? hasError,
  }) {
    return TransactionsState(
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
