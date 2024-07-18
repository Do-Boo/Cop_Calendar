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
    hintColor: Colors.black,
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
    ),
    fontFamily: "GowunDodum",
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.blue,
      selectionColor: Colors.blue,
      selectionHandleColor: Colors.green,
    ),
  ),
  AppTheme.Dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    hintColor: Colors.white,
    colorScheme: const ColorScheme.dark(
      primary: Colors.black,
    ),
    fontFamily: "GowunDodum",
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.blue,
      selectionColor: Colors.blue,
      selectionHandleColor: Colors.green,
    ),
  ),
};
