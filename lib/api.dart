import 'dart:convert';
import 'package:http/http.dart' as http;
import 'task.dart';

class ApiService {
  String apiKey = '4c9de0dd-ffbf-42b4-acd1-0e312e91085b';
  final String endpoint = 'https://todoapp-api.apps.k8s.gu.se/todos';

// Hämta alla uppgifter (GET)
Future<List<Task>> getTasks() async {
  final url = Uri.parse('$endpoint?key=$apiKey');
  print('Skickar GET-förfrågan till URL: $url');
  final response = await http.get(url);
  print('Statuskod vid hämtning (GET): ${response.statusCode}');
  print('Respons från servern: ${response.body}');
  
  if (response.statusCode == 200) {
    try {
      final List<dynamic> data = json.decode(response.body);
      return data.map((taskJson) => Task.fromJson(taskJson)).toList();
    } catch (e) {
      throw Exception('Misslyckades med att avkoda uppgifter');
    }
  } else {
    throw Exception('Misslyckades med att hämta uppgifter');
  }
}

  // Ta bort en uppgift (DELETE)
  Future<void> deleteTask(String id) async {
    final response = await http.delete(Uri.parse('$endpoint/$id?key=$apiKey'));
    print('Statuskod vid borttagning (DELETE): ${response.statusCode}');
    
    if (response.statusCode != 200) {
      throw Exception('Misslyckades med att ta bort uppgift');
    }
  }

  // Skapa en ny uppgift (POST)
  Future<void> createTask(String task) async {
    final response = await http.post(
      Uri.parse('$endpoint?key=$apiKey'),
      body: jsonEncode({'title': task, 'done': false}),
      headers: {'Content-Type': 'application/json'},
    );
    print('Statuskod vid skapande (POST): ${response.statusCode}');
    
    if (response.statusCode != 200) {
      throw Exception('Misslyckades med att skapa uppgift');
    }
  }

  // Uppdatera en uppgift (PUT)
  Future<void> updateTask(String id, Task task) async {
    final response = await http.put(
      Uri.parse('$endpoint/$id?key=$apiKey'),
      body: jsonEncode(task.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    print('Statuskod vid uppdatering (PUT): ${response.statusCode}');
    
    if (response.statusCode != 200) {
      throw Exception('Misslyckades med att uppdatera uppgift');
    }
  }
}
