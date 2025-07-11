import 'package:flutter/material.dart';

import 'welcome_screen.dart';

void main() {
  runApp(const HeaticApp());
}

class HeaticApp extends StatelessWidget {
  const HeaticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heatic',
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

