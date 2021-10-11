import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/transactions_bloc.dart';
import 'transactions_table.dart';
import 'package:pw_flutter/repositories/transactions_repository/transactions_repository.dart';

class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionsRepository = TransactionsRepository();

    return RepositoryProvider.value(
      value: transactionsRepository,
      child: BlocProvider<TransactionsBloc>(
        create: (_) => TransactionsBloc(transactionsRepository: transactionsRepository)
          ..add(TransactionsGetTransactions()),
        child: TransactionTable()
      ),
    );
  }
}
