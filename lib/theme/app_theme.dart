import 'package:flutter/material.dart';

enum AppTheme {
  Light,
  Dark,
}

final appThemeData = {
  AppTheme.Light: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    hintColor: const Color.fromARGB(255, 13, 16, 18),
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
    ),
    fontFamily: "GowunDodum",
  ),
  AppTheme.Dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(255, 13, 16, 18),
    scaffoldBackgroundColor: const Color.fromARGB(255, 13, 16, 18),
    hintColor: Colors.white,
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 13, 16, 18),
    ),
    fontFamily: "GowunDodum",
  ),
};
