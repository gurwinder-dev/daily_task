import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class MentionTextField extends StatefulWidget {
  const MentionTextField({super.key});

  @override
  State<MentionTextField> createState() => _MentionTextFieldState();
}

class _MentionTextFieldState extends State<MentionTextField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<String> _usernames = ['@aman', '@harsh', '@gurwinderjit'];
  final List<String> _topics = ['#Politics', '#Tech', '#Sports'];

  List<String> _suggestions = [];
  String _trigger = '';
  int _triggerIndex = -1;

  void _onTextChanged(String text) {
    final cursorPos = _controller.selection.baseOffset;

    if (cursorPos <= 0 || cursorPos > text.length) {
      _clearSuggestions();
      return;
    }

    final textUntilCursor = text.substring(0, cursorPos);
    final match = RegExp(r'[@#][\w]*$').firstMatch(textUntilCursor);

    if (match != null) {
      _trigger = match.group(0) ?? '';
      _triggerIndex = match.start;

      if (_trigger.startsWith('@')) {
        _suggestions = _usernames
            .where((u) => u.toLowerCase().contains(_trigger.toLowerCase()))
            .toList();
      } else {
        _suggestions = _topics
            .where((t) => t.toLowerCase().contains(_trigger.toLowerCase()))
            .toList();
      }
    } else {
      _clearSuggestions();
    }

    setState(() {});
  }

  void _clearSuggestions() {
    _trigger = '';
    _triggerIndex = -1;
    _suggestions = [];
  }

  void _insertMention(String value) {
    final text = _controller.text;
    final before = text.substring(0, _triggerIndex);
    final after = text.substring(_controller.selection.baseOffset);
    final newText = '$before$value $after';

    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: (before + value).length + 1),
    );

    _clearSuggestions();
    setState(() {});
  }

  void _navigateTo(String tag) {
    if (tag.startsWith('@')) {
      Navigator.pushNamed(context, '/profile', arguments: tag.substring(1));
    } else if (tag.startsWith('#')) {
      Navigator.pushNamed(context, '/topic', arguments: tag.substring(1));
    }
  }

  List<TextSpan> _buildStyledText(String text) {
    final RegExp regex = RegExp(r'([@#][\w]+)');
    final matches = regex.allMatches(text);

    if (matches.isEmpty) {
      return [TextSpan(text: text, style: TextStyle(color: Colors.black))];
    }

    List<TextSpan> spans = [];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: TextStyle(color: Colors.black),
        ));
      }

      final mention = match.group(0)!;
      final color = mention.startsWith('@') ? Colors.blue : Colors.green;

      spans.add(
        TextSpan(
          text: mention,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
          recognizer: TapGestureRecognizer()
            ..onTap = () => _navigateTo(mention),
        ),
      );

      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: TextStyle(color: Colors.black),
      ));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final previewText = _controller.text;
    final textSpans = _buildStyledText(previewText);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          maxLines: null,
          onChanged: _onTextChanged,
          decoration: InputDecoration(
            hintText: 'Write a comment...',
            border: OutlineInputBorder(),
          ),
        ),
        if (_suggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 4),
            color: Colors.grey[200],
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _suggestions.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(_suggestions[index]),
                  onTap: () => _insertMention(_suggestions[index]),
                );
              },
            ),
          ),
        const SizedBox(height: 20),
        const Text('Preview:', style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: RichText(
            text: TextSpan(children: textSpans),
          ),
        ),
      ],
    );
  }
}
