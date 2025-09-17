import 'package:flutter/material.dart';
import 'features/debate/presentation/screens/create_debate_screen.dart';

void main() {
  runApp(const DebateApp());
}

class DebateApp extends StatelessWidget {
  const DebateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debate App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home:const CreateDebateScreen(),
    );
  }
}
