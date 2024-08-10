import 'package:events_app/api/api_database_query.dart';
import 'package:events_app/g_gets.dart';
import 'package:events_app/widgets/w_button.dart';
import 'package:events_app/widgets/w_calendar.dart';
import 'package:events_app/widgets/w_custom_dialog.dart';
import 'package:events_app/widgets/w_round_widget.dart';
import 'package:events_app/widgets/w_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = DScrollController.to.scrollController;
    final screenSize = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Calendar(),
          ),
          Obx(() {
            final room = SelectedRoomController.to.selectedRoom;
            return DraggableScrollableSheet(
              controller: controller,
              initialChildSize: (screenSize.height - screenSize.width - 56) / screenSize.height,
              minChildSize: (screenSize.height - screenSize.width - 56) / screenSize.height,
              maxChildSize: 1,
              snap: true,
              snapSizes: [(screenSize.height - screenSize.width - 56) / screenSize.height, 1],
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  color: theme.primaryColor,
                  child: Column(
                    children: [
                      _buildDragHandle(),
                      _buildRoomSelectionButtons(room),
                      _buildRoomList(scrollController),
                    ],
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDragHandle() {
    return SizedBox(
      height: 5,
      child: Row(
        children: [
          const Expanded(child: SizedBox()),
          Expanded(
            child: Container(
              width: 60,
              decoration: BoxDecoration(
                color: theme.hintColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
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
        future: fetchReportTableJsonData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.active) {
            return _BuildLodingWidget();
          } else if (snapshot.hasData) {
            var items = snapshot.data as List<dynamic>;
            return Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: Key(items[index]["id"]),
                    background: Container(
                      color: Colors.green,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.edit, color: Colors.white),
                    ),
                    secondaryBackground: Container(
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.call_outlined, color: Colors.white),
                    ),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Delete action')));
                        return false;
                      } else if (direction == DismissDirection.startToEnd) {
                        _controller.text = "";
                        showModalBottomSheet<void>(
                          backgroundColor: Theme.of(context).hintColor,
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                height: 148,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(0.9),
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 4,
                                      width: 128,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.green,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          const Icon(Icons.calendar_month_outlined, size: 16),
                                          const SizedBox(width: 8),
                                          Text(
                                            DateFormat("MM.dd.(EE)", "ko_KR").format(SelectedDayController.to.selectedDay),
                                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(width: 16),
                                          Text(
                                            items[index]["회의실"].toString().replaceAll("<br>", ""),
                                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    RoundWidget(
                                      padding: const EdgeInsets.all(0),
                                      margin: const EdgeInsets.all(0),
                                      color: Theme.of(context).hintColor.withOpacity(0.1),
                                      child: SizedBox(
                                        height: 48,
                                        child: TextField(
                                          controller: _controller,
                                          focusNode: _focusNode,
                                          decoration: const InputDecoration(
                                            hintText: "메모를 입력하세요",
                                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                          ),
                                          onSubmitted: (value) async {
                                            String result = await insertTel(items[index]["id"], value);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(result)),
                                            );
                                            Get.back();
                                          },
                                        ),
                                      ),
                                    ),
                                    const Expanded(child: SizedBox()),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _focusNode.requestFocus();
                        });
                        return false;
                      }
                      return false;
                    },
                    child: GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          barrierColor: Colors.black.withOpacity(0.2),
                          builder: (context) {
                            return CustomDialogWidget(
                              child: Row(
                                children: [
                                  Container(width: 1, color: Theme.of(context).hintColor.withOpacity(0.3)),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(height: 1, color: Theme.of(context).hintColor.withOpacity(0.3)),
                                        const Expanded(child: Center(child: Text("회의실"))),
                                        Container(height: 1, color: Theme.of(context).hintColor.withOpacity(0.3)),
                                        const Expanded(child: Center(child: Text("사용시간"))),
                                        Container(height: 1, color: Theme.of(context).hintColor.withOpacity(0.3)),
                                        const Expanded(child: Center(child: Text("회의명"))),
                                        Container(height: 1, color: Theme.of(context).hintColor.withOpacity(0.3)),
                                        const Expanded(child: Center(child: Text("부서"))),
                                        Container(height: 1, color: Theme.of(context).hintColor.withOpacity(0.3)),
                                      ],
                                    ),
                                  ),
                                  Container(width: 1, color: Theme.of(context).hintColor.withOpacity(0.3)),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(height: 1, color: Theme.of(context).hintColor.withOpacity(0.3)),
                                        Expanded(
                                          child: Center(
                                            child: Text(items[index]["회의실"].toString().replaceAll("<br>", "\r\n"), textAlign: TextAlign.center),
                                          ),
                                        ),
                                        Container(height: 1, color: Theme.of(context).hintColor.withOpacity(0.3)),
                                        Expanded(child: Center(child: Text(items[index]["사용시간"].toString().split(">")[1]))),
                                        Container(height: 1, color: Theme.of(context).hintColor.withOpacity(0.3)),
                                        Expanded(child: Center(child: Text(items[index]["회의명"].toString(), textAlign: TextAlign.center))),
                                        Container(height: 1, color: Theme.of(context).hintColor.withOpacity(0.3)),
                                        Expanded(child: Center(child: Text(items[index]["사용부서"].toString()))),
                                        Container(height: 1, color: Theme.of(context).hintColor.withOpacity(0.3)),
                                      ],
                                    ),
                                  ),
                                  Container(width: 1, color: Theme.of(context).hintColor.withOpacity(0.3)),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: ListTile(
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
                      ),
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
                color: theme.hintColor.withOpacity(0.2),
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
