import 'package:events_app/g_gets.dart';
import 'package:events_app/page/p_calender_page.dart';
import 'package:events_app/widgets/w_button.dart';
import 'package:events_app/widgets/w_custom_appbar.dart';
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
      drawer: Drawer(
        child: Obx(() {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AuthController.to.id),
                Image.network(AuthController.to.profile),
                Text(AuthController.to.name),
              ],
            ),
          );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          Obx(() {
            if (!SelectedDayController.to.isAtToday) {
              return SizedBox(
                height: 28,
                width: 78,
                child: Button(
                  color: Theme.of(context).hintColor.withOpacity(0.3),
                  onPressed: () {
                    SelectedDayController.to.selectedDay = DateTime.now();
                    HapticFeedback.lightImpact();
                  },
                  child: const Text("오늘"),
                ),
              );
            }
            return const SizedBox();
          }),
        ],
      ),
      body: const CalenderPage(),
    );
  }
}
