import 'package:events_app/g_gets.dart';
import 'package:events_app/widgets/w_calendar.dart';
import 'package:events_app/widgets/w_custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final controllerX = Get.put(ScrollControllerX());

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const Drawer(),
      body: Container(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Calendar(),
            ),
            DraggableScrollableSheet(
              initialChildSize: (screenSize.height - screenSize.width - 56) / screenSize.height,
              minChildSize: (screenSize.height - screenSize.width - 56) / screenSize.height,
              maxChildSize: 1,
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                        child: Row(
                          children: [
                            const Expanded(child: SizedBox()),
                            Expanded(
                              child: Container(
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).hintColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: 25,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(title: Text('Item ${index + 1}'));
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
