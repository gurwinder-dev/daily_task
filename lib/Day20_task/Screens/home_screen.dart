
import 'package:flutter/material.dart';
import '../Models/debate.dart';
import '../widgets/debate_card.dart';
import 'bookmarked_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Debate> _debates = [
    Debate(id: '1', title: 'Social Media Regulation', description: 'Should governments regulate platforms more strictly?'),
    Debate(id: '2', title: 'Remote Work Future', description: 'Is remote work here to stay?'),
    Debate(id: '3', title: 'Climate Change Policies', description: 'Are global efforts effective?'),
    Debate(id: '4', title: 'Universal Basic Income', description: 'Can UBI reduce poverty and job insecurity?'),
    Debate(id: '5', title: 'Online Learning vs. Traditional Learning', description: 'Which leads to better outcomes?'),
    Debate(id: '6', title: 'Free College Education', description: 'Should higher education be free for all?'),

  ];

  void _toggleBookmark(String id) {
    setState(() {
      final index = _debates.indexWhere((d) => d.id == id);
      _debates[index].isBookmarked = !_debates[index].isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debates'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmarks),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookmarkedScreen(
                    bookmarkedDebates:
                    _debates.where((d) => d.isBookmarked).toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: _debates
            .map((debate) => DebateCard(
          debate: debate,
          onBookmarkToggle: () => _toggleBookmark(debate.id),
        ))
            .toList(),
      ),
    );
  }
}
