import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sing_up_form.dart';
import '../bloc/sign_up_bloc.dart';
import 'package:pw_flutter/repositories/authentication_repository/authentication_repository.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authenticationRepository = context.read<AuthenticationRepository>();

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => SignUpBloc(authenticationRepository: authenticationRepository),
        child: SignUpForm(),
      ),
    );
  }
}
