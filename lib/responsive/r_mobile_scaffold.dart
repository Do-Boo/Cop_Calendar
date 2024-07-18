import 'package:events_app/api/api_database_query.dart';
import 'package:events_app/g_gets.dart';
import 'package:events_app/page/p_calender_page.dart';
import 'package:events_app/page/p_sign_page.dart';
import 'package:events_app/widgets/w_button.dart';
import 'package:events_app/widgets/w_calendar.dart';
import 'package:events_app/widgets/w_custom_appbar.dart';
import 'package:events_app/widgets/w_shimmer.dart';
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
  final _controller = DScrollController.to.scrollController;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const Drawer(),
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
      body: const SignPage(),
    );
  }
}
