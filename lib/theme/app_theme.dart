import 'package:flutter/material.dart';

enum AppTheme {
  Light,
  Dark,
}

final appThemeData = {
  AppTheme.Light: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
      onPrimary: Color.fromARGB(255, 135, 128, 236),
      secondary: Color.fromARGB(255, 31, 31, 31),
      onSurface: Color.fromARGB(255, 31, 31, 31),
    ),
  ),
  AppTheme.Dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(255, 31, 31, 31),
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 31, 31, 31),
      onPrimary: Colors.white,
      secondary: Colors.red,
      onSurface: Colors.white,
    ),
  ),
};
