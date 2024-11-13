import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';
import 'checkboxwidget.dart';
import 'newpage.dart';
import 'task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      taskProvider.fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('TIG333 TODO'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                _filter = value;
              });
            },
            itemBuilder: (BuildContext context) {
              return <String>['all', 'completed', 'incomplete'].map((String value) {
                return PopupMenuItem<String>(
                  value: value,
                  child: Text(
                    value == 'all'
                        ? 'Visa alla'
                        : value == 'completed'
                            ? 'Visade avklarade'
                            : 'Visade icke-avklarade',
                  ),
                );
              }).toList();
            },
            tooltip: 'Visa meny',
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          // Filtera uppgifterna baserat på valt filter
          List<Task> filteredTasks;
          if (_filter == 'completed') {
            filteredTasks = taskProvider.tasks.where((task) => task.isChecked).toList();
          } else if (_filter == 'incomplete') {
            filteredTasks = taskProvider.tasks.where((task) => !task.isChecked).toList();
          } else {
            filteredTasks = taskProvider.tasks;
          }

          return taskProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxWidget(
                                task: task.task,
                                isChecked: task.isChecked,
                                onChanged: (bool? value) {
                                  if (value != null) {
                                    taskProvider.updateTaskStatus(task.id, value);
                                  }
                                },
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.black),
                              onPressed: () {
                                taskProvider.deleteTask(task.id);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 1),
                        Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ],
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Lägg till uppgifter',
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewPage()),
          );
          if (newTask != null && newTask.isNotEmpty) {
            context.read<TaskProvider>().addTask(newTask);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
