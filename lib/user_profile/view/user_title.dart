import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_profile_bloc.dart';

class UserTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 5),
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: const Color(0xffaf8eb5),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                      offset: Offset(0.0, 1.5),
                      blurRadius: 1.0
                  )
                ],
              ),
              child: Center(
                child: Text(state.user.email ?? ''),
              ),
            ),
          )
        );
      },
    );
  }
}
