import "package:flutter/material.dart";
import "package:events_app/g_gets.dart";
import "package:flutter/services.dart";

class DatePicker extends StatelessWidget {
  const DatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = SelectedDayController.to.selectedDay;
    final yearController = FixedExtentScrollController(initialItem: date.year - 2024);
    final monthController = FixedExtentScrollController(initialItem: date.month - 1);
    final dayController = FixedExtentScrollController(initialItem: date.day - 1);

    final years = List<int>.generate(3, (i) => i + 2024);
    final months = List<int>.generate(12, (i) => i + 1);
    final days = List<int>.generate(31, (i) => i + 1);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40, bottom: 72),
            decoration: BoxDecoration(
              color: theme.hintColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildDatePicker("Year", years, yearController, theme),
              Container(height: 80, width: 1, color: theme.hintColor.withOpacity(0.3)),
              buildDatePicker("Month", months, monthController, theme),
              Container(height: 80, width: 1, color: theme.hintColor.withOpacity(0.3)),
              buildDatePicker("Day", days, dayController, theme),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDatePicker(String label, List<int> values, FixedExtentScrollController controller, ThemeData theme) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 120,
            child: ListWheelScrollView(
              controller: controller,
              useMagnifier: true,
              magnification: 1.2,
              itemExtent: 40.0,
              onSelectedItemChanged: (index) {
                DateTime date = SelectedDayController.to.selectedDay;
                SelectedDayController.to.selectedDay = DateTime(
                  label == "Year" ? values[index] : date.year,
                  label == "Month" ? values[index] : date.month,
                  label == "Day" ? values[index] : date.day,
                );
                controller.animateToItem(
                  index,
                  duration: const Duration(microseconds: 200),
                  curve: Curves.easeInOut,
                );
                HapticFeedback.lightImpact();
              },
              children: values
                  .map(
                    (value) => Center(
                      child: Text(
                        value.toString(),
                        style: TextStyle(
                          fontSize: 21,
                          fontFamily: "GowunDodum",
                          color: theme.hintColor.withOpacity(0.8),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
