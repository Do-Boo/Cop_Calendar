import 'package:events_app/g_gets.dart';
import 'package:events_app/page/p_calender_page.dart';
import 'package:events_app/widgets/w_button.dart';
import 'package:events_app/widgets/w_custom_appbar.dart';
import 'package:events_app/widgets/w_custom_drawer.dart';
import 'package:events_app/widgets/w_round_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  _MobileScaffoldState createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  RxBool isToggled = false.obs;

  void toggleButton() {
    isToggled.value = !isToggled.value;
    HapticFeedback.lightImpact();
  }

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
                onPressed: () => showCustomModal(context),
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
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: const CalenderPage(),
    );
  }

  void showCustomModal(BuildContext context) {
    _controller1.text = "";
    _controller2.text = "";
    showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).hintColor,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: 216,
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
                    color: Colors.blue,
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
                      const Expanded(child: SizedBox()),
                      SizedBox(
                        height: 28,
                        width: 28,
                        child: Obx(() {
                          return Button(
                            color: Colors.transparent,
                            onPressed: toggleButton,
                            child: Icon(isToggled.value ? CupertinoIcons.bell_fill : CupertinoIcons.bell, size: 18),
                          );
                        }),
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
                      controller: _controller1,
                      focusNode: _focusNode1,
                      decoration: const InputDecoration(
                        hintText: "제목을 입력하세요",
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onSubmitted: (value) {
                        FocusScope.of(context).requestFocus(value.isEmpty ? _focusNode1 : _focusNode2);
                      },
                    ),
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
                      controller: _controller2,
                      focusNode: _focusNode2,
                      decoration: const InputDecoration(
                        hintText: "할 일을 입력하세요",
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onSubmitted: (_) async {},
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
      _focusNode1.requestFocus();
    });
    HapticFeedback.lightImpact();
  }
}
