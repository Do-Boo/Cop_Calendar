import 'package:events_app/theme/app_theme.dart';
import 'package:events_app/widgets/w_app_bar.dart';
import 'package:events_app/widgets/w_button.dart';
import 'package:events_app/widgets/w_round_widget.dart';
import 'package:events_app/widgets/w_select_group.dart';
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
      debugShowCheckedModeBanner: false,
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
                      alignment: Alignment.centerLeft,
                      height: 72,
                      child: const Text(
                        "Test",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SelectGroup(),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                                  border: Border.all(
                                    width: 2,
                                    color: const Color.fromARGB(255, 235, 235, 235),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 40, child: RoundWidget()),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      height: 56,
                                      child: RoundWidget(
                                        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                          child: const Row(
                                            children: [
                                              SizedBox(width: 40, child: RoundButton(color: Colors.white)),
                                              SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  "Test",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              SizedBox(width: 40, child: RoundButton(color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      height: 256,
                                      child: RoundWidget(
                                        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.1),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      height: 40,
                                      child: RoundButton(
                                        child: Text("Create +", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              flex: 5,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                                  border: Border.all(
                                    width: 2,
                                    color: const Color.fromARGB(255, 235, 235, 235),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
