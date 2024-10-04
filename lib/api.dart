import 'dart:convert';
import 'package:http/http.dart' as http;
import 'task.dart';

class ApiService {
  String apiKey = 'e5aad64f-3dbf-4633-a02c-943d8be9f3c4';
  final String endpoint = 'https://todoapp-api.apps.k8s.gu.se';

  // Hämta alla uppgifter (GET)
  Future<List<Task>> getTasks() async {
    final response = await http.get(Uri.parse(endpoint));
    print('Statuskod vid hämtning (GET): ${response.statusCode}');
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((taskJson) => Task.fromJson(taskJson)).toList();
    } else {
      throw Exception('Misslyckades med att ladda uppgift');
    }
  }

  // Ta bort en uppgift (DELETE)
  Future<void> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('$endpoint/$id'));
    print('Statuskod vid borttagning (DELETE): ${response.statusCode}');
    if (response.statusCode != 200) {
      throw Exception('Misslyckades med att ta bort uppgift');
    }
  }

  // Skapa en ny uppgift (POST)
  Future<void> createTask(String task) async {
    final response = await http.post(
      Uri.parse(endpoint),
      body: jsonEncode({'task': task, 'isChecked': false}),
      headers: {'Content-Type': 'application/json'},
    );
    print('Statuskod vid skapande (POST): ${response.statusCode}');
    if (response.statusCode != 201) {
      throw Exception('Misslyckades med att skapa uppgift');
    }
  }

  // Uppdatera en uppgift (PUT)
  Future<void> updateTask(int id, Task task) async {
    final response = await http.put(
      Uri.parse('$endpoint/$id'),
      body: jsonEncode(task.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    print('Statuskod vid uppdatering (PUT): ${response.statusCode}');
    if (response.statusCode != 200) {
      throw Exception('Misslyckades med att uppdatera uppgift');
    }
  }
}
