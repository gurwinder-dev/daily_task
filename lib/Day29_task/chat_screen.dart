import 'dart:async';
import 'package:first_task/Day29_task/user_model.dart';
import 'package:flutter/material.dart';
import 'user_status_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<UserModel> users = [
    UserModel(name: "Aman", isOnline: false),
    UserModel(name: "Harsh", isOnline: true),
    UserModel(name: "Gurwinderjit", isOnline: true),
  ];

  final TextEditingController _controller = TextEditingController();
  Timer? typingTimer;

  void _onInputChanged(String text) {
    _setTyping("You", text.isNotEmpty);

    if (text.isNotEmpty) {
      _simulateOtherUserTyping("Harsh");
      _simulateOtherUserTyping("Gurwinderjit");
    }
  }

  void _setTyping(String name, bool isTyping) {
    final index = users.indexWhere((u) => u.name == name);
    if (index != -1) {
      setState(() {
        users[index].isTyping = isTyping;
      });

      if (isTyping) {
        typingTimer?.cancel();
        typingTimer = Timer(Duration(seconds: 3), () {
          setState(() {
            users[index].isTyping = false;
          });
        });
      }
    }
  }

  void _simulateOtherUserTyping(String name) {
    final index = users.indexWhere((u) => u.name == name);
    if (index == -1) return;

    setState(() => users[index].isTyping = true);

    Timer(Duration(milliseconds: 2000 + index * 500), () {
      setState(() => users[index].isTyping = false);
    });
  }

  @override
  void dispose() {
    typingTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Debate Room",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, index) {
                final user = users[index];
                return UserStatusWidget(
                  name: user.name,
                  isOnline: user.isOnline,
                  isTyping: user.isTyping,
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: _onInputChanged,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      if (_controller.text.trim().isEmpty) return;
                      print("Message Sent: ${_controller.text}");

                      _controller.clear();
                      _setTyping("You", false);
                    },
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}