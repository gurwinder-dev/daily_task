import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: DebateThreadPage(),
    debugShowCheckedModeBanner: false,
  ));
}
class DebateThreadPage extends StatefulWidget {
  const DebateThreadPage({super.key});

  @override
  State<DebateThreadPage> createState() => _DebateThreadPageState();
}

class _DebateThreadPageState extends State<DebateThreadPage> {
  final String debateStatement = 'Should remote work be permanent?';

  List<Comment> comments = [
    Comment(
      username: 'SimarAjnala',
      text: 'I think remote work improves productivity.',
      replies: [
        Comment(username: 'Punjabiqueen', text: 'Agreed'),
        Comment(username: 'Flutterdev', text: 'But some people miss the office vibe.'),
        Comment(username: 'RajeshK01', text: 'I agreed'),
      ],
    ),
    Comment(
      username: 'AndroidDev',
      text: 'Permanent remote work may harm collaboration.',
      replies: [
        Comment(username: 'PreetBhakha', text: 'Right'),
        Comment(username: 'Coder099', text: 'Only if companies don’t adapt tools properly.'),
        Comment(username: 'JaspalSingh203', text: 'Exactly. With the right tools, remote works great.'),
      ],),
      Comment(
        username: 'GlobalCitizen',
        text: 'Remote work helps companies hire globally. Huge win for diversity!',
        replies: [
          Comment(username: 'DevIndia', text: 'True! I got my first US job remotely.'),
        ],
      ),
    Comment(
      username: 'SimTech',
      text: 'Remote work allows introverts to shine without office distractions.',
      replies: [
        Comment(username: 'KomalChoudhary01', text: 'But extroverts need that team energy to thrive.'),
      ],
    ),
  ];

  void addReply(Comment parent, Comment reply) {
    setState(() {
      parent.replies.add(reply);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debate Thread')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              debateStatement,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: comments.map((comment) {
                  return CommentCard(
                    comment: comment,
                    onReply: (reply) => addReply(comment, reply),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CommentCard extends StatefulWidget {
  final Comment comment;
  final int indentLevel;
  final Function(Comment)? onReply;

  const CommentCard({
    super.key,
    required this.comment,
    this.indentLevel = 0,
    this.onReply,
  });

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool showReplyField = false;
  final TextEditingController replyController = TextEditingController();

  void handleReply() {
    final replyText = replyController.text.trim();
    if (replyText.isNotEmpty) {
      final newReply = Comment(
        username: 'You',
        text: replyText,
      );

      if (widget.onReply != null) {
        widget.onReply!(newReply);
      } else {
        setState(() {
          widget.comment.replies.add(newReply);
        });
      }

      replyController.clear();
      setState(() {
        showReplyField = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widget.indentLevel * 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text(widget.comment.username.substring(0, 3).toUpperCase()),
            ),
            title: Text(widget.comment.username),
            subtitle: Text(widget.comment.text),
            trailing: IconButton(
              icon: const Icon(Icons.reply),
              onPressed: () {
                setState(() {
                  showReplyField = !showReplyField;
                });
              },
            ),
          ),
          if (showReplyField)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  TextField(
                    controller: replyController,
                    decoration: const InputDecoration(
                      hintText: "Write a reply...",
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: handleReply,
                      child: const Text("Post"),
                    ),
                  ),
                ],
              ),
            ),
          const Divider(),


          ...widget.comment.replies.map((reply) {
            return CommentCard(
              comment: reply,
              indentLevel: widget.indentLevel + 1,
              onReply: (newReply) {
                setState(() {
                  reply.replies.add(newReply);
                });
              },
            );
          }),
        ],
      ),
    );
  }
}


class Comment {   ///comment model
  final String username;
  final String text;
  final List<Comment> replies;

  Comment({
    required this.username,
    required this.text,
    List<Comment>? replies,
  }) : replies = replies ?? [];
}
