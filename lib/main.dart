import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_provider.dart';
import 'homepage.dart';

void main() {
  runApp(
    // Omge hela applikationen med ChangeNotifierProvider
    ChangeNotifierProvider(
      create: (context) => TaskProvider(), // Skapar och tillhandahåller TaskProvider
      child: const MyApp(), // Appen använder Provider
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inlämningsuppgift 1',
      home: const HomePage(),
    );
  }
}
