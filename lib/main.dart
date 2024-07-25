import "package:events_app/api/api_data.dart";
import "package:events_app/g_gets.dart";
import "package:events_app/responsive/r_desktop_scaffold.dart";
import "package:events_app/responsive/r_layout.dart";
import "package:events_app/responsive/r_mobile_scaffold.dart";
import "package:events_app/responsive/r_tablet_scaffold.dart";
import "package:events_app/theme/app_theme.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:flutter_localizations/flutter_localizations.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkTheme = prefs.getBool("isDarkTheme") ?? false;

  KakaoSdk.init(
    nativeAppKey: kakaoNativeAppKey,
    javaScriptAppKey: kakaoJavaScriptAppKey,
  );

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
          Get.put(SelectedRoomController());
          Get.put(DScrollController());
          Get.put(AuthController());
        }),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("ko", "KR"), // Korean
        ],
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
    return const ResponsiveLayout(
      mobileScaffold: MobileScaffold(),
      tabletScaffold: TabletScaffold(),
      desktopScaffold: DesktopScaffold(),
    );
  }
}
