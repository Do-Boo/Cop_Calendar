import "package:flutter/material.dart";

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
          title: const Text("Date Wheel Selector Example"),
        ),
        body: const Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final ScrollController _scrollController = ScrollController();
  final double minChildSize = 0.5; // minChildSize를 정의합니다.
  final double maxChildSize = 1.0; // maxChildSize를 정의합니다.

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          print('Reached minChildSize');
          // minChildSize에 도착했을 때 수행할 액션을 여기에 작성합니다.
        } else {
          print('Reached maxChildSize');
          // maxChildSize에 도착했을 때 수행할 액션을 여기에 작성합니다.
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      builder: (BuildContext context, ScrollController scrollController) {
        return ListView.builder(
          controller: _scrollController, // ScrollController를 ListView에 연결합니다.
          itemCount: 25,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text('Item ${index + 1}'));
          },
        );
      },
    );
  }
}
