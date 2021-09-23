import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pw_flutter/home/home.dart';
import 'package:pw_flutter/repositories/authentication_repository/authentication_repository.dart';
import 'package:pw_flutter/repositories/user_repository/user_repository.dart';

import 'package:pw_flutter/splash/splash.dart';
import 'package:pw_flutter/helper/enums/enums.dart';
import 'package:pw_flutter/authentication/authentication.dart';
import 'package:pw_flutter/theme.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.userRepository,
    required this.authenticationRepository
  }) : super(key: key);

  final UserRepository userRepository;
  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil(
                  HomePage.route(),
                  (route) => false
                );
                break;
              case AuthenticationStatus.unauthenticated:
              default:
                _navigator.pushAndRemoveUntil(
                  AuthenticationPage.route(),
                  (route) => false,
                );
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
