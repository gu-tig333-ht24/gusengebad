import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';
import 'checkboxwidget.dart';
import 'newpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('TIG333 TODO'),
      ),
      body: taskProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
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
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Lägg till uppgifter',
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewPage()),
          );
          if (newTask != null && newTask.isNotEmpty) {
            taskProvider.addTask(newTask);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
