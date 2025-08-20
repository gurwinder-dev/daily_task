import 'package:flutter/material.dart';
import '../Models/debate.dart';


class DebateCard extends StatefulWidget {
  final Debate debate;
  final VoidCallback onBookmarkToggle;

  const DebateCard({
    Key? key,
    required this.debate,
    required this.onBookmarkToggle,
  }) : super(key: key);

  @override
  _DebateCardState createState() => _DebateCardState();
}

class _DebateCardState extends State<DebateCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
        parent: _controller, curve: Curves.easeOutBack));
  }

  void _toggleBookmark() {
    _controller.forward().then((_) => _controller.reverse());
    widget.onBookmarkToggle();
  }

  void _shareDebate(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Debate link copied!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final debate = widget.debate;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        title: Text(debate.title),
        subtitle: Text(debate.description),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          ScaleTransition(
            scale: _scaleAnim,
            child: IconButton(
              icon: Icon(Icons.bookmark,
                  color: debate.isBookmarked ? Colors.blue : Colors.grey),
              onPressed: _toggleBookmark,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareDebate(context),
          ),
        ]),
      ),
    );
  }
}
