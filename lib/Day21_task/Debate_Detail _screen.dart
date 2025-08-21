
import 'package:flutter/material.dart';

class DebateDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Debate Detail"),
      ),
      body: Center(
        child: Text(
          'Opened Debate',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
