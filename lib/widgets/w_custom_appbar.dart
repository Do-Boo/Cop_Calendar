import 'package:events_app/g_gets.dart';
import 'package:events_app/widgets/w_date_picker.dart';
import 'package:events_app/widgets/w_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

var theme;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return SafeArea(
      top: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: preferredSize.height,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  bool isAtMax = DScrollController.to.isAtMax;
                  return Button(
                    child: Row(
                      children: [
                        Text(
                          DateFormat(isAtMax ? "yyyy.MM.dd.(EE)" : "yyyy.MM.", "ko_KR").format(SelectedDayController.to.selectedDay),
                          // DateFormat("yyyy.MM.").format(SelectedDayController.to.selectedDay),
                          textAlign: TextAlign.left,
                          style: TextStyle(color: theme.hintColor, fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                    onPressed: () => {
                      HapticFeedback.lightImpact(),
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                        pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
                          return Container(
                            alignment: Alignment.topCenter,
                            child: Container(
                              padding: EdgeInsets.only(top: statusBarHeight),
                              height: 220 + statusBarHeight,
                              color: theme.primaryColor,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    height: 56,
                                    child: Row(
                                      children: [
                                        Obx(() {
                                          return Button(
                                            color: Colors.transparent,
                                            child: Row(
                                              children: [
                                                Text(
                                                  DateFormat("yyyy.MM.").format(SelectedDayController.to.selectedDay),
                                                  // DateFormat("yyyy.MM.dd.(EE)", "ko_KR").format(SelectedDayController.to.selectedDay),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(color: theme.hintColor, fontSize: 28, fontWeight: FontWeight.bold),
                                                ),
                                                const Icon(Icons.keyboard_arrow_up),
                                              ],
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              HapticFeedback.lightImpact();
                                            },
                                          );
                                        }),
                                        const Expanded(child: SizedBox()),
                                      ],
                                    ),
                                  ),
                                  const Expanded(child: DatePicker()),
                                ],
                              ),
                            ),
                          );
                        },
                        transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                          return SlideTransition(
                            position: CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOut,
                            ).drive(Tween<Offset>(
                              begin: const Offset(0, -1.0),
                              end: const Offset(0, 0),
                            )),
                            child: child,
                          );
                        },
                      ),
                    },
                  );
                }),
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Button(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                    },
                    child: const Icon(CupertinoIcons.search),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Button(
                    child: Icon(ThemeController.to.themeMode == ThemeMode.dark ? CupertinoIcons.moon : Icons.sunny),
                    onPressed: () async {
                      ThemeController.to.toggleTheme();
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool("isDarkTheme", ThemeController.to.themeMode == ThemeMode.dark);
                      HapticFeedback.lightImpact();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
