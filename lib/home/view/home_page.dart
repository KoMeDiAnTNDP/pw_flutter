import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_bar.dart';
import 'balance.dart';
import 'side_bar.dart';
import 'package:pw_flutter/transactions/transactions.dart';
import 'package:pw_flutter/user_profile/user_profile.dart';
import 'package:pw_flutter/repositories/user_repository/user_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() =>  MaterialPageRoute<void>(builder: (_) => HomePage());

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();

    return RepositoryProvider.value(
      value: userRepository,
      child: BlocProvider(
        create: (_) => UserProfileBloc(userRepository: userRepository)..add(GetUserProfile()),
        child: BlocListener<UserProfileBloc, UserProfileState>(
          listener: (context, state) {
            if (state.hasError) {

            }
          },
          child: Scaffold(
            appBar: WingsAppBar(),
            drawer: SideBar(),
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Balance(),
                ),
                TransactionsPage()
              ],
            ),
          ),
        ),
      )
    );
  }
}
