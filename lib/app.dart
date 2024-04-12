import 'package:flutter/material.dart';
import 'main.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Project2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}