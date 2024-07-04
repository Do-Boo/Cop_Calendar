import 'package:events_app/g_gets.dart';
import 'package:events_app/widgets/w_button.dart';
import 'package:events_app/widgets/w_round_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final day = ValueNotifier<DateTime>(DateTime(SelectedDayController.to.selectedDay.year, SelectedDayController.to.selectedDay.month, 1));
    final pageController = PageController(initialPage: SelectedDayController.to.selectedDay.month - 1);

    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: GridView.count(
              crossAxisCount: 7,
              physics: const NeverScrollableScrollPhysics(),
              children: weekdays.map((text) => Center(child: Text(text, style: TextStyle(color: theme.hintColor, fontWeight: FontWeight.bold)))).toList(),
            ),
          ),
          Expanded(
            flex: 7,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (value) {
                day.value = DateTime(SelectedDayController.to.selectedDay.year, value + 1, 1);
              },
              itemBuilder: (context, index) {
                return ValueListenableBuilder(
                  valueListenable: day,
                  builder: (context, value, child) {
                    return Obx(() {
                      return GridView.count(
                        crossAxisCount: 7,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(42, (index) {
                          final calculatedDay = value.add(Duration(days: index - value.weekday % 7));
                          return Center(
                            child: RoundWidget(
                              padding: const EdgeInsets.all(2),
                              margin: const EdgeInsets.all(6),
                              color: _dayColor(value, index, theme, SelectedDayController.to.selectedDay) == theme.primaryColor ? theme.hintColor : null,
                              borderRadius: BorderRadius.circular(128),
                              child: Button(
                                onPressed: () => SelectedDayController.to.selectedDay = calculatedDay, // 선택된 날짜를 업데이트합니다.
                                color: _dayColor(value, index, theme, SelectedDayController.to.selectedDay) == theme.primaryColor ? theme.hintColor : null,
                                border: Border.all(color: theme.primaryColor, width: 1),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Expanded(child: SizedBox()),
                                      Text(
                                        "${calculatedDay.day}",
                                        style: TextStyle(
                                          color: _dayColor(value, index, theme, SelectedDayController.to.selectedDay),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Expanded(child: Row()),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _dayColor(DateTime day, int index, ThemeData theme, DateTime selectedDay) {
    final days = day.add(Duration(days: index - day.weekday % 7));

    if (days.month == day.month) {
      if (selectedDay.month == days.month && selectedDay.day == days.day) return theme.primaryColor;
      if (days.weekday == 6) return Colors.blue;
      if (days.weekday == 7) return Colors.red;
      return theme.hintColor;
    } else {
      return theme.hintColor.withOpacity(0.3);
    }
  }
}
