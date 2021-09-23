import 'package:flutter/material.dart';

final theme = ThemeData(
  primaryColor: const Color(0xff9b27af),
  primaryColorLight: const Color(0xffcf5ce2),
  primaryColorDark: const Color(0xff69007f),
  brightness: Brightness.light,
  primaryColorBrightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: const Color(0xff9b27af),
    primaryVariant: const Color(0xffcf5ce2),
    secondary: const Color(0xffe1bee7),
    secondaryVariant: const Color(0xffaf8eb5),
    onPrimary: const Color(0xffffffff),
    onSecondary: const Color(0xff000000)
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: const Color(0xffcf5ce2),
  ),
  scaffoldBackgroundColor: const Color(0xffe1e1e2),
  backgroundColor: const Color(0xffe1e1e2),
  tabBarTheme: TabBarTheme(
    labelColor: const Color(0xffffffff),
  ),
  indicatorColor: const Color(0xffe1bee7),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: const Color(0xffe1bee7),
      onPrimary: const Color(0xff000000)
    )
  ),
);
