import 'package:flutter/material.dart';
import '../Models/debate.dart';
import '../widgets/debate_card.dart';

class BookmarkedScreen extends StatelessWidget {
  final List<Debate> bookmarkedDebates;

  const BookmarkedScreen({Key? key, required this.bookmarkedDebates})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarked Debates')),
      body: bookmarkedDebates.isEmpty
          ? const Center(child: Text('No bookmarks yet.'))
          : ListView.builder(
        itemCount: bookmarkedDebates.length,
        itemBuilder: (context, index) {
          final debate = bookmarkedDebates[index];
          return DebateCard(
            debate: debate,
            onBookmarkToggle: () {},
          );
        },
      ),
    );
  }
}
