import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pw_flutter/sign_in/sign_in.dart';
import 'package:pw_flutter/sign_up/sign_up.dart';

class TabBarContainer extends Container implements PreferredSizeWidget {
  TabBarContainer(
    this.backgroundColor,
    this.tabBar, {
      Key? key
  }) : super(key: key);

  final Color backgroundColor;
  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
    color: backgroundColor,
    child: tabBar,
  );
}

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({ Key? key }) : super(key: key);

  static Route route() => MaterialPageRoute<void>(builder: (_) => AuthenticationPage());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'images/parrot.svg',
                width: 50,
              ),
              Text('Parrot Wings'),
            ],
          ),
          bottom: TabBarContainer(
            Theme.of(context).primaryColorLight,
            const TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 6.0,
              labelPadding: EdgeInsets.all(3.0),
              tabs: [
                Tab(text: 'Sign In'),
                Tab(text: 'Sign Up'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SignInPage(),
            SignUpPage(),
          ],
        ),
      )
    );
  }
}
