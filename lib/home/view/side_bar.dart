import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pw_flutter/user_profile/user_profile.dart';
import 'package:pw_flutter/authentication/authentication.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }
}
