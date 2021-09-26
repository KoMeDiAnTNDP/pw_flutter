import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pw_flutter/helper/models/models.dart';
import 'package:pw_flutter/user_profile/user_profile.dart';

class Balance extends StatelessWidget {
  Widget balanceText(int? balance, bool isLoading) {
    if (isLoading || balance == null) {
      return CircularProgressIndicator();
    }

    return Text(
      balance.toString(),
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.0
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Your Balance:',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: balanceText(state.user.balance, state.isLoading),
              )
            ],
          ),
        );
      },
    );
  }
}
