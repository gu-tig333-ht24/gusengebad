import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

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
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Skriv din uppgift här',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                print('Uppgift skickad tillbaka: ${controller.text}');
                Navigator.pop(context, controller.text);
              },
              child: const Text('Lägg till uppgift'),
            ),
          ],
        ),
      ),
    );
  }
}
