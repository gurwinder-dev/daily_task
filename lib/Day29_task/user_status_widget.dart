import 'package:flutter/material.dart';

class UserStatusWidget extends StatelessWidget {
  final String name;
  final bool isOnline;
  final bool isTyping;

  const UserStatusWidget({
    Key? key,
    required this.name,
    required this.isOnline,
    required this.isTyping,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.account_circle,
        size: 36,
        color: isOnline ? Colors.green : Colors.red,
      ),
      title: Text(name),
      subtitle: isTyping
          ? const TypingIndicator()
          : Text(isOnline ? "Online" : "Offline"),
    );
  }
}

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat();

    _animation1 =
        Tween<double>(begin: 0, end: 8).animate(CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.6, curve: Curves.easeInOut)));
    _animation2 =
        Tween<double>(begin: 0, end: 8).animate(CurvedAnimation(parent: _controller, curve: Interval(0.2, 0.8, curve: Curves.easeInOut)));
    _animation3 =
        Tween<double>(begin: 0, end: 8).animate(CurvedAnimation(parent: _controller, curve: Interval(0.4, 1.0, curve: Curves.easeInOut)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(Animation<double> animation) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: AnimatedBuilder(
        animation: animation,
        builder: (_, __) => Transform.translate(
          offset: Offset(0, -animation.value),
          child:const CircleAvatar(radius: 4, backgroundColor: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Typing", style: TextStyle(fontStyle: FontStyle.italic)),
        _buildDot(_animation1),
        _buildDot(_animation2),
        _buildDot(_animation3),
      ],
    );
  }
}
