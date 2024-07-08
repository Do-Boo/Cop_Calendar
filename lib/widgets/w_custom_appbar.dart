import 'package:events_app/g_gets.dart';
import 'package:events_app/widgets/%08w_date_picker.dart';
import 'package:events_app/widgets/w_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                  return Button(
                    child: Row(
                      children: [
                        Text(
                          DateFormat(ScrollControllerX.to.isAtMax ? "yyyy.MM.dd." : "yyyy.MM.").format(SelectedDayController.to.selectedDay),
                          textAlign: TextAlign.left,
                          style: TextStyle(color: theme.hintColor, fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                    onPressed: () => {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                        pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
                          return Container(
                            alignment: Alignment.topCenter,
                            child: Container(
                              padding: const EdgeInsets.only(top: 56),
                              height: 260,
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
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(color: theme.hintColor, fontSize: 28, fontWeight: FontWeight.bold),
                                                ),
                                                const Icon(Icons.keyboard_arrow_up),
                                              ],
                                            ),
                                            onPressed: () => Navigator.of(context).pop(),
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
                    onPressed: () => print(ScrollControllerX.to.isAtMax),
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
