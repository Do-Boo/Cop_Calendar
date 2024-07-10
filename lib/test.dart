import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
          title: const Text('JSON Example'),
        ),
        body: FutureBuilder(
          future: readJsonData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              var items = snapshot.data as List<dynamic>;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  // print(items.length);
                  return Card(
                    child: ListTile(
                      title: Text(items[index]["회의실"]),
                      // subtitle: Text(items[index]['description']),
                    ),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<List<dynamic>> readJsonData() async {
    final response = await http.get(Uri.parse("http://doboo.tplinkdns.com/Web/API/jsonData.php"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
