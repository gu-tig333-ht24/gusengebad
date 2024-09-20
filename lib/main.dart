import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Inlämningsuppgift 1',
      home: HomePage(),
    ),
  );
}

// Förstasida
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> tasks = [];

  // Ta bort en uppgift
  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('TIG333 TODO'),
        actions: const [],
      ),
      body: Column(
        children: [
          tasks.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: tasks.asMap().entries.map((entry) {
                      int index = entry.key;
                      var task = entry.value;
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CheckboxWidget(
                                  task: task['task'],
                                  isChecked: task['isChecked'],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      tasks[index]['isChecked'] = value ?? false;
                                    });
                                  },
                                ),
                              ),
                              // Ta bort-knapp
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.black),
                                onPressed: () {
                                  _removeTask(index);
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
                    }).toList(),
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Inga uppgifter tillagda ännu',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Lägg till uppgifter',
        onPressed: () async {
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewPage()),
          );
          if (newTask != null && newTask.isNotEmpty) {
            setState(() {
              tasks.add({'task': newTask, 'isChecked': false});
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Sida för att lägga till uppgift
class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('TIG333 TODO'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lägg till en uppgift',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Skriv din uppgift här',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _controller.text);
              },
              child: const Text('Lägg till uppgift'),
            ),
          ],
        ),
      ),
    );
  }
}

// Checkbox-widget
class CheckboxWidget extends StatefulWidget {
  final String task;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const CheckboxWidget({
    super.key,
    required this.task,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.isChecked,
          onChanged: widget.onChanged,
        ),
        Expanded(
          child: Text(
            widget.task,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              decoration: widget.isChecked ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ],
    );
  }
}
