import 'package:flutter/material.dart';
import 'chat_screen.dart';

void main() {
  runApp(const DebateApp());
}
class DebateApp extends StatelessWidget {
  const DebateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Debate Chat',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const ChatScreen(),
    );
  }
}