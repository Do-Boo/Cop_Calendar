import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DraggableScrollableSheet Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter DraggableScrollableSheet Demo'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.blue[100],
            child: const Center(child: Text('Pull up from the bottom')),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.6, // 초기 높이를 설정합니다. 1.0은 전체 화면을 의미합니다.
            minChildSize: 0.6, // 최소 높이를 설정합니다.
            maxChildSize: 1, // 최대 높이를 설정합니다.
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                color: Colors.blue[300],
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 25,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text('Item ${index + 1}'));
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
