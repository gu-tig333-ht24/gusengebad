import 'package:flutter/material.dart';
import 'api.dart';
import 'task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = false;

  final ApiService _apiService = ApiService();

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  // Hämta alla uppgifter från API
  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners();
    print('Hämtar uppgifter från API');
    try {
      _tasks = await _apiService.getTasks();
      print('Uppgifter hämtade: ${_tasks.length}');
    } catch (e) {
      print('Kunde inte hämta uppgifter: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  // Lägg till en ny uppgift
  Future<void> addTask(String newTask) async {
    try {
      _tasks.add(Task(id: '0', task: newTask, isChecked: false));  
      notifyListeners();
      await _apiService.createTask(newTask);
      print('Uppgift skapad på servern');
      await fetchTasks();
    } catch (e) {
      print('Kunde inte lägga till uppgift: $e');
    }
  }

  // Ta bort en uppgift
  Future<void> deleteTask(String id) async {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks.removeAt(taskIndex);
      notifyListeners();
      try {
        await _apiService.deleteTask(id);
        print('Uppgift borttagen från servern');
      } catch (e) {
        print('Kunde inte ta bort uppgiften: $e');
      }
    }
  }

  // Uppdatera statusen på en uppgift
  Future<void> updateTaskStatus(String id, bool isChecked) async {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex] = Task(
        id: _tasks[taskIndex].id,
        task: _tasks[taskIndex].task,
        isChecked: isChecked,
      );
      notifyListeners();

      try {
        await _apiService.updateTask(id, _tasks[taskIndex]);
        print('Uppgiftens status uppdaterad på servern');
      } catch (e) {
        print('Kunde inte uppdatera uppgiften: $e');
      }
    }
  }
}
