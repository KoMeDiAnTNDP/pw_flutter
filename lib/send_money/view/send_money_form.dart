import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:pw_flutter/helper/models/models.dart';
import 'package:pw_flutter/helper/consts/consts.dart';

import '../bloc/send_money_bloc.dart';

class SendMoneyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SendMoneyBloc, SendMoneyState>(
      listener: (context, state) {

      },
      child: AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: Container(
          padding: EdgeInsets.all(16.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
          ),
          child: Center(
            child: Text('Send Wings', style: TextStyle(color: Colors.white)),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 300,
              padding: EdgeInsets.all(8.0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: _RecipientInput(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: _AmountInput(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: _SendButton(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

class _RecipientInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMoneyBloc, SendMoneyState>(
      buildWhen: (previous, current) {
        final isListsEqual = DeepCollectionEquality()
            .equals(previous.filteredUsers, current.filteredUsers);
        print(isListsEqual);

        return !isListsEqual || previous.recipient != current.recipient;
      },
      builder: (context, state) => TextField(
        key: const Key('send_money_form_recipient_text_field'),
        onChanged: (recipient) => context.read<SendMoneyBloc>()
            .add(SendMoneyRecipientChanged(recipient)),
        decoration: InputDecoration(
          labelText: 'Recipient',
          helperText: 'Enter the name of recipient',
          errorText: state.recipient.invalid ? 'Recipient is empty' : null,
        ),
      )
    );
  }
}

class _AmountInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMoneyBloc, SendMoneyState>(
      buildWhen: (previous, current) => previous.amount != current.amount,
      builder: (context, state) => TextField(
        key: const Key('send_money_form_amount_text_field'),
        onChanged: (amount) {
          print('here $amount');
          final parseDouble = double.tryParse(amount) ?? state.amount.value;
          print('parseDouble $parseDouble');

          context.read<SendMoneyBloc>()
              .add(SendMoneyAmountChanged(parseDouble));
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Amount',
          helperText: 'Enter the number you want to send',
          errorText: state.amount.invalid ? 'Wrong value' : null,
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMoneyBloc, SendMoneyState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) => ElevatedButton(
        key: const Key('send_money_submit_button'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)
          ),
        ),
        onPressed: state.status.isValidated
            ? () => context.read<SendMoneyBloc>().add(SendMoneySubmitted())
            : null,
        child: Text('Send'),
      ),
    );
  }
}
