import 'package:events_app/g_gets.dart';
import 'package:events_app/page/p_calender_page.dart';
import 'package:events_app/widgets/w_button.dart';
import 'package:events_app/widgets/w_custom_appbar.dart';
import 'package:events_app/widgets/w_custom_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  _MobileScaffoldState createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  var theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const Drawer(
        child: CustomDrawer(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 16.0,
            left: MediaQuery.of(context).size.width - 8 - 72, // 중앙 하단
            child: SizedBox(
              height: 54,
              width: 54,
              child: Button(
                color: Theme.of(context).hintColor.withOpacity(0.3),
                onPressed: () {
                  HapticFeedback.lightImpact();
                },
                child: const Icon(Icons.add),
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: MediaQuery.of(context).size.width / 2 - 36,
            child: SizedBox(
              height: 28,
              width: 72,
              child: Obx(() {
                return !SelectedDayController.to.isAtToday
                    ? Button(
                        color: Theme.of(context).hintColor.withOpacity(0.3),
                        onPressed: () {
                          SelectedDayController.to.selectedDay = DateTime.now();
                          HapticFeedback.lightImpact();
                        },
                        child: const Text("오늘"),
                      )
                    : const SizedBox();
              }),
            ),
          ),
          // Obx(() {
          //   if (!SelectedDayController.to.isAtToday) {
          //     return Positioned(
          //       bottom: 16.0,
          //       left: MediaQuery.of(context).size.width / 2 - 36, // 중앙 하단
          //       child: SizedBox(
          //         height: 28,
          //         width: 72,
          //         child: Button(
          //           color: Theme.of(context).hintColor.withOpacity(0.3),
          //           onPressed: () {
          //             SelectedDayController.to.selectedDay = DateTime.now();
          //             HapticFeedback.lightImpact();
          //           },
          //           child: const Text("오늘"),
          //         ),
          //       ),
          //     );
          //   }
          //   return const SizedBox();
          // }),
        ],
      ),
      body: const CalenderPage(),
    );
  }
}
