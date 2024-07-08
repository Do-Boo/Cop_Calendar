import 'package:events_app/widgets/%08w_date_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Date Wheel Selector Example'),
        ),
        body: const Center(
          child: DatePicker(),
        ),
      ),
    );
  }
}

class DatePickerWheel extends StatefulWidget {
  const DatePickerWheel({super.key});

  @override
  _DatePickerWheelState createState() => _DatePickerWheelState();
}

class _DatePickerWheelState extends State<DatePickerWheel> {
  FixedExtentScrollController yearController = FixedExtentScrollController();
  FixedExtentScrollController monthController = FixedExtentScrollController();
  FixedExtentScrollController dayController = FixedExtentScrollController();

  List<int> years = List<int>.generate(31, (i) => i + 1990);
  List<int> months = List<int>.generate(12, (i) => i + 1);
  List<int> days = List<int>.generate(31, (i) => i + 1);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildDatePicker('Year', years, yearController),
        buildDatePicker('Month', months, monthController),
        buildDatePicker('Day', days, dayController),
      ],
    );
  }

  Widget buildDatePicker(String label, List<int> values, FixedExtentScrollController controller) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 100.0,
            child: ListWheelScrollView(
              controller: controller,
              itemExtent: 30.0,
              onSelectedItemChanged: (index) {
                print('$label: ${values[index]}');
              },
              children: values.map((value) => Center(child: Text(value.toString()))).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
