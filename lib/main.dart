import 'package:events_app/g_gets.dart';
import 'package:events_app/theme/app_theme.dart';
import 'package:events_app/widgets/w_calendar.dart';
import 'package:events_app/widgets/w_custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkTheme = prefs.getBool("isDarkTheme") ?? false;
  runApp(MyApp(isDarkTheme));
}

class MyApp extends StatelessWidget {
  final bool initialTheme;
  const MyApp(this.initialTheme, {super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    themeController.themeMode = initialTheme ? ThemeMode.dark : ThemeMode.light;
    return Obx(
      () => GetMaterialApp(
        initialBinding: BindingsBuilder(() {
          Get.put(SelectedDayController());
        }),
        theme: appThemeData[AppTheme.Light],
        darkTheme: appThemeData[AppTheme.Dark],
        themeMode: themeController.themeMode,
        home: const BasePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        alignment: Alignment.topCenter,
        child: const Calendar(),
      ),
    );
  }
}
