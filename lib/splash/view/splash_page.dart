import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffc158dc),
        child: Center(
          child: SvgPicture.asset(
            'assets/parrot.svg',
            semanticsLabel: 'Parrot',
          ),
        ),
      )
    );
  }
}