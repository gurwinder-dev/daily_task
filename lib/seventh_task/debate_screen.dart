import 'package:flutter/material.dart';

void main() {
  runApp(const HeaticApp());
}

class HeaticApp extends StatelessWidget {
  const HeaticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heatic',
      home: debateScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class debateScreen extends StatefulWidget {
  const debateScreen({super.key});

  @override
  State<debateScreen> createState() => _debateScreenState();
}

class _debateScreenState extends State<debateScreen> {

  final TextEditingController _opinionController = TextEditingController();
  final List<String> _topics = [
    'Health', 'Education', 'Sports', 'Environment', 'Art', 'Tech', 'Politics'
  ];

  String? _selectedTopic;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Debate'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _opinionController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: "Write your opinion here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: _selectedTopic,
              hint: Text("Select a topic"),
              items: _topics.map((topic) {
                return DropdownMenuItem<String>(
                  value: topic,
                  child: Text(topic),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTopic = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              final opinion = _opinionController.text.trim();
              if (opinion.isEmpty || _selectedTopic == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please enter your opinion and select a topic")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Debate posted successfully!")),
                );
              }
            },
            child: Text("Post"),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
