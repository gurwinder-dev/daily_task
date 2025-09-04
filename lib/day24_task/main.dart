import 'package:flutter/material.dart';
import 'screens/recommendations_screen.dart';

void main() {
  runApp(DebateApp());
}

class DebateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Debate Recommendation Engine',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: RecommendationsScreen(),
    );
  }
}
