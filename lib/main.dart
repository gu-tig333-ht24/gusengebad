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
class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: const Text(
                    'Handla ☐',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 1),
                Container(
                  height: 1,
                  color: Colors.black,
                ),
                const SizedBox(height: 1),
                Container(
                  padding: EdgeInsets.all(10),
                  child: const Text(
                    'Städa ☐',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 1),
                Container(
                  height: 1,
                  color: Colors.black,
                ),
                const SizedBox(height: 1),
                Container(
                  padding: EdgeInsets.all(10),
                  child: const Text(
                    'Tvätta ☐',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Lägg till uppgifter',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewPage()),
          );
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
              decoration: InputDecoration(
                labelText: 'Skriv din uppgift här',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
              },
              child: const Text('Lägg till uppgift'),
            ),
          ],
        ),
      ),
    );
  }
}
