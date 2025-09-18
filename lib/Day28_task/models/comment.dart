class Comment {
  final String id;
  final String content;
  final List<Comment> replies;
  final Map<String, int> reactions;
  bool isExpanded;
  bool isReplying;

  Comment({
    required this.id,
    required this.content,
    this.replies = const [],
    Map<String, int>? reactions,
    this.isExpanded = false,
    this.isReplying = false,
  }) : reactions = reactions ?? {
    '👍': 0,
    '👎': 0,
    '❤️': 0,
    '😂': 0,
  };
}
