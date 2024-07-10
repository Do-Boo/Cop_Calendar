import 'package:events_app/api/json_data.dart';
import 'package:events_app/g_gets.dart';
import 'package:events_app/widgets/w_button.dart';
import 'package:events_app/widgets/w_calendar.dart';
import 'package:events_app/widgets/w_custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Expanded(
                              child: Button(
                                color: Theme.of(context).hintColor.withOpacity(0.2),
                                child: const Text("전체", style: TextStyle(fontSize: 18)),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Button(
                                color: Theme.of(context).hintColor.withOpacity(0.2),
                                child: const Text("1청사", style: TextStyle(fontSize: 18)),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Button(
                                color: Theme.of(context).hintColor.withOpacity(0.2),
                                child: const Text("2청사", style: TextStyle(fontSize: 18)),
                                onPressed: () {},
                              ),
                            ),
                            const Expanded(flex: 3, child: SizedBox()),
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: Button(
                                onPressed: () {},
                                child: const Icon(CupertinoIcons.refresh),
                              ),
                            ),
                          ],
                        ),
                        // Text(
                        //   DateFormat("MM.dd.(EE)", "ko_KR").format(SelectedDayController.to.selectedDay),
                        //   style: const TextStyle(
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ),
                      FutureBuilder(
                        future: readJsonData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else if (snapshot.hasData) {
                            var items = snapshot.data as List<dynamic>;
                            return Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: items.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Row(
                                      children: [
                                        Container(
                                          height: 36,
                                          width: 4,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).hintColor.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(items[index]["회의실"].toString().replaceAll("<br>", " ")),
                                            Text(items[index]["사용시간"].toString().split(">")[1]),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
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
