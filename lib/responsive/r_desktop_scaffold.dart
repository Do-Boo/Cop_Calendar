import 'package:events_app/api/api_database_query.dart';
import 'package:events_app/g_gets.dart';
import 'package:events_app/widgets/w_button.dart';
import 'package:events_app/widgets/w_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  var theme;
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Obx(() {
        final room = SelectedRoomController.to.selectedRoom;
        return Container(
          color: theme.primaryColor,
          child: Column(
            children: [
              _buildRoomSelectionButtons(room),
              _buildRoomList(scrollController),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildRoomSelectionButtons(String room) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          _buildRoomButton(room, "", "전체"),
          const SizedBox(width: 16),
          _buildRoomButton(room, "서소문청사", "1청사"),
          const SizedBox(width: 16),
          _buildRoomButton(room, "서소문2", "2청사"),
          const Expanded(flex: 2, child: SizedBox()),
          SizedBox(
            width: 40,
            height: 40,
            child: Button(
              onPressed: () {
                refeshList();
                HapticFeedback.lightImpact();
              },
              child: const Icon(CupertinoIcons.refresh),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomButton(String room, String roomValue, String buttonText) {
    return Expanded(
      child: Button(
        color: theme.hintColor.withOpacity(room == roomValue ? 0.3 : 0.2),
        child: Text(buttonText, style: const TextStyle(fontSize: 18)),
        onPressed: () {
          HapticFeedback.lightImpact();
          SelectedRoomController.to.selectedRoom = roomValue;
        },
      ),
    );
  }

  Widget _buildRoomList(ScrollController scrollController) {
    return Obx(() {
      SelectedDayController.to.selectedDay;
      return FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 300), () => fetchReportTableJsonData()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active) {
            return _BuildLodingWidget();
          } else if (snapshot.hasError) {
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SelectableText(items[index]["회의실"].toString().replaceAll("<br>", " ")),
                            _BuildLineWidget(),
                            SelectableText(items[index]["회의명"].toString().replaceAll("<br>", " ")),
                            _BuildLineWidget(),
                            SelectableText(items[index]["사용부서"].toString().replaceAll("<br>", " ")),
                            _BuildLineWidget(),
                            SelectableText(items[index]["사용시간"].toString().split(">")[1]),
                            _BuildLineWidget(),
                            SelectableText(items[index]["신청자"].toString().replaceAll("<br>", " ")),
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
      );
    });
  }

  Widget _BuildLineWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 36,
        width: 2,
        decoration: BoxDecoration(
          color: Theme.of(context).hintColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Widget _BuildLodingWidget() {
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
  }
}
