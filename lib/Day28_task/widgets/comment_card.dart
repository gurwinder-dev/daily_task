import 'package:flutter/material.dart';
import '../models/comment.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;
  final int depth;
  final Function(String parentId, String replyText) onReply;

  const CommentCard({
    super.key,
    required this.comment,
    required this.onReply,
    this.depth = 0,
  });

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  final replyController = TextEditingController();

  void toggleReaction(String emoji) {
    setState(() {
      widget.comment.reactions[emoji] =
          (widget.comment.reactions[emoji] ?? 0) + 1;
    });
  }

  void toggleReply() {
    setState(() {
      widget.comment.isReplying = !widget.comment.isReplying;
    });
  }

  void submitReply() {
    if (replyController.text.isNotEmpty) {
      widget.onReply(widget.comment.id, replyController.text);
      replyController.clear();
      toggleReply();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: widget.depth * 20.0, top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.comment.content),
                  const SizedBox(height: 8),
                  Row(
                    children: widget.comment.reactions.entries.map((entry) {
                      return GestureDetector(
                        onTap: () => toggleReaction(entry.key),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text("${entry.key} ${entry.value}"),
                        ),
                      );
                    }).toList(),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: toggleReply,
                        child: const Text("Reply"),
                      ),
                      if (widget.comment.replies.isNotEmpty)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              widget.comment.isExpanded =
                              !widget.comment.isExpanded;
                            });
                          },
                          child: Text(widget.comment.isExpanded
                              ? "Hide replies"
                              : "View more replies"),
                        ),
                    ],
                  ),
                  if (widget.comment.isReplying)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: replyController,
                              decoration: const InputDecoration(
                                hintText: "Write a reply...",
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: submitReply,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

          /// Nested replies
          if (widget.comment.isExpanded)
            Column(
              children: widget.comment.replies
                  .map(
                    (reply) => CommentCard(
                  comment: reply,
                  depth: widget.depth + 1,
                  onReply: widget.onReply,
                ),
              )
                  .toList(),
            ),
        ],
      ),
    );
  }
}
