import 'package:flutter/material.dart';

void main() {
  runApp(HeaticDebateFeed());
}

class HeaticDebateFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heatic Debate Feed',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: DebateFeedPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DebateFeedPage extends StatefulWidget {
  @override
  State<DebateFeedPage> createState() => _DebateFeedPageState();
}

class _DebateFeedPageState extends State<DebateFeedPage> {
  final List<Map<String, dynamic>> debateData = [
    {
      'username': 'Simran123',
      'opinion': 'I believe AI will enhance human creativity, not replace it.',
      'likes': 30,
    },
    {
      'username': 'Rockstar405',
      'opinion': 'Social media is more harmful than helpful in today’s society.',
      'likes': 12,
    },
    {
      'username': 'Punjab_Queen',
      'opinion': 'Remote work increases productivity and employee satisfaction.',
      'likes': 36,
    },
    {
      'username': 'jaspal_dev',
      'opinion': 'Universal basic income is essential in an automated future.',
      'likes': 19,
    },
    {
      'username': 'PreetAmritsar01',
      'opinion': 'Governments should ban single-use plastics entirely.',
      'likes': 19,
    },{
     'username': 'GlobalEdu',
      'opinion': 'Access to free quality education is a fundamental human right, not a privilege.',
     'likes': 55,
    },

  ];

  List<bool> liked = [];

  @override
  void initState() {
    super.initState();
    liked = List.filled(debateData.length, false);
  }

  void _handleLike(int index) {
    setState(() {
      if (liked[index]) {
        debateData[index]['likes'] += 1;
        liked[index] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Debate Feed'),
      ),
      body: ListView.builder(
        itemCount: debateData.length,
        itemBuilder: (context, index) {
          final debate = debateData[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    debate['username'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    debate['opinion'],
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Likes: ${debate['likes']}'),
                      ElevatedButton(
                        onPressed: () => _handleLike(index),
                        child: Text(liked[index] ? 'Liked' : 'Like'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
