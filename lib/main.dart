import 'package:flutter/material.dart';

import 'package:pw_flutter/app.dart';
import 'package:pw_flutter/repositories/user_repository/user_repository.dart';
import 'package:pw_flutter/repositories/authentication_repository/authentication_repository.dart';

void main() {
  runApp(App(
    userRepository: UserRepository(),
    authenticationRepository: AuthenticationRepository())
  );
}
