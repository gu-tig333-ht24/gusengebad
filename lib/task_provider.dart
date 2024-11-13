import 'package:flutter/material.dart';
import 'api.dart';
import 'task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = false;

  final ApiService _apiService = ApiService();

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  // Hämta alla uppgifter
  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners();
    print('Hämtar uppgifter från API');
    try {
      _tasks = await _apiService.getTasks();
      print('Uppgifter hämtade: ${_tasks.length}');
    } catch (e) {
      print('Kunde inte hämta uppgifter: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Lägg till en ny uppgift
  Future<void> addTask(String title) async {
    String newId = DateTime.now().millisecondsSinceEpoch.toString();
    final newTask = Task(id: newId, task: title, isChecked: false);
    _tasks.add(newTask);
    notifyListeners();
    try {
      await _apiService.createTask(title);
      print('Uppgift skapad på servern');
    } catch (e) {
      _tasks.remove(newTask);
      notifyListeners();
      print('Kunde inte lägga till uppgiften på servern: $e');
    }
  }

  // Ta bort en uppgift
  Future<void> deleteTask(String id) async {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      final taskToRemove = _tasks[taskIndex];
      _tasks.removeAt(taskIndex);
      notifyListeners();
      try {
        await _apiService.deleteTask(id);
        print('Uppgift borttagen från servern');
      } catch (e) {
        _tasks.insert(taskIndex, taskToRemove);
        notifyListeners();
        print('Kunde inte ta bort uppgiften: $e');
      }
    }
  }

  // Uppdatera statusen på en uppgift
  Future<void> updateTaskStatus(String id, bool isChecked) async {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      final originalTask = _tasks[taskIndex];
      _tasks[taskIndex] = Task(
        id: originalTask.id,
        task: originalTask.task,
        isChecked: isChecked,
      );
      notifyListeners();
      try {
        await _apiService.updateTask(id, _tasks[taskIndex]);
        print('Uppgiftens status uppdaterad på servern');
      } catch (e) {
        _tasks[taskIndex] = originalTask;
        notifyListeners();
        print('Kunde inte uppdatera uppgiften på servern: $e');
      }
    }
  }
}
