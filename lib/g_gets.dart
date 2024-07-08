import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();
  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;

  ThemeMode get themeMode => _themeMode.value;
  set themeMode(ThemeMode mode) => _themeMode.value = mode;

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

class SelectedDayController extends GetxController {
  static SelectedDayController get to => Get.find();
  final Rx<DateTime> _selectedDay = DateTime.now().obs;

  DateTime get selectedDay => _selectedDay.value;
  set selectedDay(DateTime day) => _selectedDay.value = day;
}

class ScrollControllerX extends GetxController {
  static ScrollControllerX get to => Get.find();
  final RxBool _isAtMax = false.obs;

  bool get isAtMax => _isAtMax.value;

  void checkIfAtMax(ScrollController scrollController) {
    if (scrollController.position.atEdge) {
      _isAtMax.value = scrollController.position.pixels == scrollController.position.maxScrollExtent;
    }
  }
}
