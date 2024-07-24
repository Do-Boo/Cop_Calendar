import 'dart:math';
import 'package:flutter/material.dart';

Color generateRandomColor() {
  final random = Random();
  return Color.fromRGBO(
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
    1,
  );
}

get complementaryColor => randomColor.fromRGBO(255 - randomColor.red, 255 - randomColor.green, 255 - randomColor.blue, 1);
get randomColor => generateRandomColor();
