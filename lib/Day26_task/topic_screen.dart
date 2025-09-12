import 'package:flutter/material.dart';

class TopicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final topic = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    return Scaffold(
      appBar: AppBar(title: Text('#$topic')),
      body: Center(child: Text("Exploring topic: #$topic")),
    );
  }
}
