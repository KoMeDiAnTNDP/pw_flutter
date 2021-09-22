import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_in_form.dart';
import 'package:pw_flutter/sign_in/bloc/sign_in_bloc.dart';
import 'package:pw_flutter/repositories/authentication_repository/authentication_repository.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authenticationRepository = context.read<AuthenticationRepository>();

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => SignInBloc(authenticationRepository: authenticationRepository),
        child: SignInForm(),
      ),
    );
  }
}
