
import 'package:flutter/material.dart';
import 'Notification_screen.dart';


void main() => runApp(DebateApp());
class DebateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Debate App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: NotificationScreen(),
    );
  }
}
