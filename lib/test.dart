import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Screen Transition Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Screen1(),
    );
  }
}

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('화면 1'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Hero(
          tag: '버튼',
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Screen2()),
              );
            },
            child: const Text('화면 2로 이동'),
          ),
        ),
      ),
    );
  }
}

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('화면 2'),
      ),
      body: Hero(
        tag: '버튼',
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue,
          child: const Center(
            child: Text('화면 2'),
          ),
        ),
      ),
    );
  }
}
