import 'package:flutter/material.dart';
import 'dart:core';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'header.dart';
import '../bloc/transactions_bloc.dart';
import 'package:pw_flutter/helper/models/models.dart';
import 'package:pw_flutter/helper/utils/date_formatter.dart';

class TransactionTable extends StatelessWidget {
  Widget _createTransaction(Transaction transaction) {
    final color = transaction.amount > 0 ? Colors.green : Colors.redAccent;

    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              DateFormatter.getVerboseDateTimeRepresentation(transaction.date),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: Text(transaction.name, textAlign: TextAlign.center),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                transaction.amount > 0
                    ? Icon(Icons.arrow_upward, color: color)
                    : Icon(Icons.arrow_downward, color: color),
                Padding(
                  padding: EdgeInsets.only(left: 3.0),
                  child: Text(
                    transaction.amount.abs().toString(),
                    style: TextStyle(color: color),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              transaction.balance.toString(),
              textAlign: TextAlign.end,
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }

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

    return Container(
      constraints: BoxConstraints(
        maxHeight: 500,
      ),
      padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: transactions
            .map(_createTransaction)
            .toList(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionsBloc, TransactionsState>(
      listener: (context, state) {},
      child: BlocBuilder<TransactionsBloc, TransactionsState>(
        buildWhen: (previous, current) =>
          !DeepCollectionEquality
            .unordered()
            .equals(previous.transactions, current.transactions),
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
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
              )
            ],
          );
        },
      ),
    );
  }
}