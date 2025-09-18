import 'package:flutter/material.dart';
import '../models/comment.dart';
import '../widgets/comment_card.dart';
import 'package:uuid/uuid.dart';

class DebateDetailScreen extends StatefulWidget {
  const DebateDetailScreen({super.key});

  @override
  State<DebateDetailScreen> createState() => _DebateDetailScreenState();
}

class _DebateDetailScreenState extends State<DebateDetailScreen> {
  final List<Comment> comments = [
    Comment(id: '1', content: "I think technology is amazing!"),
    Comment(id: '2', content: "Actually, it depends on the context."),
  ];

  final uuid = const Uuid();

  void addReply(String parentId, String replyText, [List<Comment>? list]) {
    list ??= comments;

    for (var comment in list) {
      if (comment.id == parentId) {
        setState(() {
          comment.replies.add(
            Comment(id: uuid.v4(), content: replyText),
          );
          comment.isExpanded = true;
        });
        return;
      } else {
        addReply(parentId, replyText, comment.replies);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: Text("Debate Detail"),
      )),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: comments.map(
              (comment) => CommentCard(
            comment: comment,
            onReply: addReply,
          ),
        )
            .toList(),
      ),
    );
  }
}
