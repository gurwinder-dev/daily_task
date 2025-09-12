import 'package:flutter/material.dart';
import 'mention_text_field.dart';
import 'profile_screen.dart';
import 'topic_screen.dart';

void main() {
  runApp(MentionsApp());
}

class MentionsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debate Mentions System',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home:const HomeScreen(),
      routes: {
        '/profile': (_) => ProfileScreen(),
        '/topic': (_) => TopicScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Debate Comment')),
      body:const Padding(
        padding:  EdgeInsets.all(16.0),
        child: MentionTextField(),
      ),
    );
  }
}
