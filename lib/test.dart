import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'), // Korean
      ],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('날짜 선택 예제'),
        ),
        body: const Center(
          child: MyDatePicker(),
        ),
      ),
    );
  }
}

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({super.key});

  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '선택된 날짜: ${_date.year}-${_date.month}-${_date.day}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        CupertinoButton(
          color: Colors.blue,
          child: const Text('날짜 선택'),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (_) => Container(
                height: 250,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          setState(() {
                            _date = val;
                          });
                        },
                      ),
                    ),

                    // Close the modal
                    CupertinoButton(
                      child: const Text('확인'),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
