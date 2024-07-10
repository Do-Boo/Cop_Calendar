import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> readJsonData() async {
  final response = await http.get(Uri.parse("http://doboo.tplinkdns.com/Web/API/jsonData.php"));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}
