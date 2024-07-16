import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
  final df = DateFormat("yyyy-MM-dd");

  DateTime get selectedDay => _selectedDay.value;
  bool get isAtToday => df.format(selectedDay) == df.format(DateTime.now());
  set selectedDay(DateTime day) => _selectedDay.value = day;
}

class SelectedRoomController extends GetxController {
  static SelectedRoomController get to => Get.find();
  final RxString _selectedRoom = "".obs;

  String get selectedRoom => _selectedRoom.value;
  set selectedRoom(String room) => _selectedRoom.value = room;
}

class DScrollController extends GetxController {
  static DScrollController get to => Get.find();
  final _scrollController = DraggableScrollableController();
  final RxDouble _isValue = 0.0.obs;
  final RxBool _isAtMax = false.obs;

  double get isValue => _isValue.value;
  DraggableScrollableController get scrollController => _scrollController;
  bool get isAtMax => _isAtMax.value;
  set isValue(double value) => _isValue.value = value;
  set isAtMax(bool value) => _isAtMax.value = value;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() => isAtMax = scrollController.size == 0.95);
  }
}
