import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'header.dart';
import '../bloc/transactions_bloc.dart';
import 'package:pw_flutter/helper/models/models.dart';

class TransactionTable extends StatelessWidget {
  Widget _transactionsList(List<Transaction> transactions, BuildContext context) {
    if (transactions.isEmpty) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('You don\'t have wings yet'),
          ),
        ],
      );
    }

    return Expanded(child: Center(child: Text('center')));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionsBloc, TransactionsState>(
      listener: (context, state) {},
      child: BlocBuilder<TransactionsBloc, TransactionsState>(
        buildWhen: (previous, current) =>
          DeepCollectionEquality
            .unordered()
            .equals(previous.transactions, current.transactions),
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0)
                    )
                  ),
                  child: Header(),
                ),
                _transactionsList(state.transactions, context),
              ],
            ),
          );
        },
      )
    );
  }
}