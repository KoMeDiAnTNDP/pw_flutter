import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pw_flutter/user_profile/bloc/user_profile_bloc.dart';

import 'send_money_form.dart';
import '../bloc/send_money_bloc.dart';
import 'package:pw_flutter/transactions/transactions.dart';
import 'package:pw_flutter/repositories/user_repository/user_repository.dart';
import 'package:pw_flutter/repositories/transactions_repository/transactions_repository.dart';

class SendMoneyPage extends StatelessWidget {
  SendMoneyPage({
    Key? key,
    required double balance,
    required BuildContext parentContext,
  }) : _balance = balance, _parentContext = parentContext, super(key: key);

  final double _balance;
  final BuildContext _parentContext;

  @override
  Widget build(BuildContext context) {
    final initialState = SendMoneyState(balance: _balance);
    final userRepository = _parentContext.read<UserRepository>();
    final transactionsBloc = _parentContext.read<TransactionsBloc>();
    final transactionsRepository = _parentContext.read<TransactionsRepository>();

    return BlocProvider(
      create: (context) {
        return SendMoneyBloc(
          initialState: initialState,
          transactionsBloc: transactionsBloc,
          userRepository: userRepository,
          transactionsRepository: transactionsRepository,
        );
      },
      child: SendMoneyForm(),
    );
  }
}
