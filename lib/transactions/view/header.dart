import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pw_flutter/user_profile/user_profile.dart';
import 'package:pw_flutter/send_money/view/send_money_page.dart';

class Header extends StatelessWidget {
  Widget _createTile(String title, { TextAlign align = TextAlign.center }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Text(
          title,
          textAlign: align,
        ),
      ),
    );
  }

  void openCreateModal(BuildContext context, double? balance) => showDialog(
    context: context,
    builder: (BuildContext dialogContext) {

      return SendMoneyPage(balance: balance ?? 0.0, parentContext: context);
    }
  );


  @override
  Widget build(BuildContext context) {
    final user = context.select((UserProfileBloc bloc) => bloc.state.user);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.secondaryVariant,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                )
              )
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RawMaterialButton(
                  onPressed: () => openCreateModal(context, user.balance),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  child: Icon(Icons.add),
                )
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _createTile('Date/Time of the transaction', align: TextAlign.start),
              _createTile('Correspondent Name'),
              _createTile('Transaction amount'),
              _createTile('Resulting balance', align: TextAlign.right),
            ],
          ),
        ],
      ),
    );
  }
}
