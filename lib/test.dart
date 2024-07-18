import 'package:events_app/widgets/w_custom_dialog.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Alert Dialog Example'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Show Alert Dialog'),
          onPressed: () {
            showDialog(context: context, builder: (context) => const CustomDialogWidget());
          },
        ),
      ),
    );
  }
}
