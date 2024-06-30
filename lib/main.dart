import 'package:buttons_flutter/buttons_flutter.dart';
import 'package:events_app/theme/app_theme.dart';
import 'package:events_app/widgets/w_app_bar.dart';
import 'package:events_app/widgets/w_button.dart';
import 'package:events_app/widgets/w_round_widget.dart';
import 'package:events_app/widgets/w_side_menu_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateProvider<bool>((ref) => false);
// final sideBarProvider = StateProvider<bool>((ref) => false);
// final pageNameProvider = StateProvider<String>((ref) => "Home");

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeProvider);
    return MaterialApp(
      theme: appThemeData[AppTheme.Light],
      darkTheme: appThemeData[AppTheme.Dark],
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: const BasePage(),
      // debugShowCheckedModeBanner: false,
    );
  }
}

class BasePage extends ConsumerWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            const SideMenuBar(),
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    const MainAppBar(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      height: 72,
                      child: const Placeholder(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      height: 104,
                      child: const Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(height: 32, child: Placeholder()),
                                SizedBox(height: 40, child: Placeholder()),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(height: 32, child: Placeholder()),
                                SizedBox(height: 40, child: Placeholder()),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(height: 32, child: Placeholder()),
                                SizedBox(height: 40, child: Placeholder()),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(height: 24, child: Placeholder()),
                                SizedBox(height: 32, child: Placeholder()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Placeholder(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
