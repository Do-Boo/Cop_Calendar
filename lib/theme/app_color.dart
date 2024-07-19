import 'dart:math';
import 'package:flutter/material.dart';

Color getRandomColor() {
  final random = Random();
  return Color.fromRGBO(
    random.nextInt(256), // Red
    random.nextInt(256), // Green
    random.nextInt(256), // Blue
    1, // Alpha
  );
}

get rndColor => getRandomColor();
