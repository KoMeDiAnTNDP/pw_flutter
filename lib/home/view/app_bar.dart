import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
