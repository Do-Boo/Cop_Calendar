import 'package:events_app/g_gets.dart';
import 'package:events_app/widgets/w_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: preferredSize.height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "February",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: theme.hintColor, fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "2024",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: theme.hintColor, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            const SizedBox(width: 40, height: 40, child: Placeholder()),
            const SizedBox(width: 16),
            SizedBox(
              width: 40,
              height: 40,
              child: Button(
                onPressed: () async {
                  ThemeController.to.toggleTheme();
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool("isDarkTheme", ThemeController.to.themeMode == ThemeMode.dark);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
