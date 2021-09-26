import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pw_flutter/authentication/authentication.dart';
import 'package:pw_flutter/repositories/user_repository/user_repository.dart';
import 'package:pw_flutter/user_profile/user_profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() =>  MaterialPageRoute<void>(builder: (_) => HomePage());

  @override
  Widget build(BuildContext context) {
    final token = context.select((AuthenticationBloc bloc) => bloc.state.token);
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
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'images/wings_left.svg',
                    width: 35.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Text('Your Wings'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: SvgPicture.asset(
                      'images/wings_right.svg',
                      width: 35.0,
                    ),
                  )
                ],
              ),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    // child: Text('some'),
                    child: UserTitle(),
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: const Text('Logout'),
                    onTap: () {
                      context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
            body: Center(
              child: Text(token),
            ),
          ),
        ),
      )
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: SvgPicture.asset(
                'images/wings_left.svg',
                width: 35.0,
              ),
            ),
            const Text('Your Wings'),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: SvgPicture.asset(
                'images/wings_right.svg',
                width: 35.0,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            key: const Key('home_page_logout_icon_button'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested()),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Text('Some'),
              curve: Curves.easeInOut,
            )
          ],
        ),
      ),
      body: Center(
        child: Text(token),
      ),
    );
  }
}
