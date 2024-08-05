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
          title: const Text('Dismissible Example'),
        ),
        body: const MyList(),
      ),
    );
  }
}

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  final List<String> items = List<String>.generate(10, (i) => 'Item ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(items[index]),
          background: Container(
            color: Colors.green,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.edit, color: Colors.white),
          ),
          secondaryBackground: Container(color: Colors.red, child: const Icon(Icons.delete, color: Colors.white)),
          onDismissed: (direction) {
            setState(() {
              if (direction == DismissDirection.endToStart) {
                items.removeAt(index);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item deleted')));
              } else if (direction == DismissDirection.startToEnd) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edit action')));
              }
            });
          },
          child: ListTile(
            title: Text(items[index]),
          ),
        );
      },
    );
  }
}
