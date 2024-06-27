import 'package:events_app/theme/app_theme.dart';
import 'package:events_app/widgets/w_side_menu_bar.dart';
import 'package:flutter/material.dart';
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
    return const Scaffold(
      body: Center(
        child: Row(
          children: [
            SideMenuBar(),
            Expanded(
              child: Row(
                children: [
                  Text("Dash board, Roles, Calendar"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
