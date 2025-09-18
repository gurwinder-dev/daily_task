import 'package:flutter/material.dart';
import 'screens/debate_detail_screen.dart';

void main() {
  runApp(const DebateApp());
}

class DebateApp extends StatelessWidget {
  const DebateApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Debate Threads 💬🔥',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const DebateDetailScreen(),
    );
  }
}
