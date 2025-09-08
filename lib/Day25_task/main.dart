import 'package:flutter/material.dart';
import 'screens/new_debate_screen.dart';
import 'screens/drafts_screen.dart';

void main() {
  runApp(const DebateDraftsApp());
}

class DebateDraftsApp extends StatelessWidget {
  const DebateDraftsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debate Drafts',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debate Drafts')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('New Debate'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const NewDebateScreen()));
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('My Drafts'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const DraftsScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
