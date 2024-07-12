import "dart:convert";
import "package:events_app/g_gets.dart";
import "package:http/http.dart" as http;

Future<List<dynamic>> readJsonData() async {
  final response = await http.post(
    Uri.parse("http://doboo.tplinkdns.com/Web/API/jsonData.php"),
    body: {
      "room1": SelectedRoomController.to.selectedRoom,
      "sdate": SelectedDayController.to.selectedDay.toIso8601String().substring(0, 10),
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception("Failed to load data");
  }
}

Future<void> refeshList() async {
  final response = await http.post(
    Uri.parse('http://doboo.tplinkdns.com/Web/API/list_update_query.php'),
  );

  if (response.statusCode == 200) {
    SelectedDayController.to.selectedDay;
    print(response.body);
  } else {
    throw Exception("Failed to load data");
  }
}
