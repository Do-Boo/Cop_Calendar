import 'package:events_app/theme/app_theme.dart';
import 'package:events_app/widgets/w_shimmer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appThemeData[AppTheme.Light],
      darkTheme: appThemeData[AppTheme.Dark],
      themeMode: ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Shimmer Loading Example'),
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: SizedBox(
                height: 36,
                child: Row(
                  children: [
                    Container(
                      height: double.infinity,
                      width: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: ShimmerWidget(borderRadius: BorderRadius.circular(4))),
                          const SizedBox(height: 4),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(child: ShimmerWidget(borderRadius: BorderRadius.circular(4))),
                                const Expanded(child: SizedBox()),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
