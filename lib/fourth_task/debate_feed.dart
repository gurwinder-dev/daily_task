import 'package:flutter/material.dart';
void main() {
  runApp(HeaticDebateFeed());
}

class HeaticDebateFeed extends StatefulWidget {
  @override
  State<HeaticDebateFeed> createState() => _HeaticDebateFeedState();
}

class _HeaticDebateFeedState extends State<HeaticDebateFeed> {

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
      'category': 'Tech',
    },
    {
      'username': 'Rockstar405',
      'opinion': 'Social media is more harmful than helpful in today’s society.',
      'likes': 12,
      'category': 'Politics',
    },
    {
      'username': 'Punjab_Queen',
      'opinion': 'Remote work increases productivity and employee satisfaction.',
      'likes': 36,
      'category': 'Tech',
    },
    {
      'username': 'jaspal_dev',
      'opinion': 'Universal basic income is essential in an automated future.',
      'likes': 19,
      'category': 'Politics',
    },
    {
      'username': 'PreetAmritsar01',
      'opinion': 'Governments should ban single-use plastics entirely.',
      'likes': 19,
      'category': 'Environment',
    }, {
      'username': 'GlobalEdu',
      'opinion': 'Access to free quality education is a fundamental human right, not a privilege.',
      'likes': 55,
      'category': 'Education',
    },
    {
      'username': 'CricketFan99',
      'opinion': 'Sports build discipline and teamwork like no other activity.',
      'likes': 22,
      'category': 'Sports',
    },

  ];

   List<String> categories = ['All','Education','Sports','Tech','Politics','Environment'];
   String selectedCategory = 'All';


  List<bool> liked = [];

  @override
  void initState() {
    super.initState();
    liked = List.filled(debateData.length, false);
  }

  void _handleLike(Map<String, dynamic> debate) {
    setState(() {
      final originalIndex = debateData.indexOf(debate);
      if (liked[originalIndex]) {
        debateData[originalIndex]['likes'] += 1;
        liked[originalIndex] = true;
      }
    });
  }


  List<Map<String, dynamic>> get filteredDebates {
    if (selectedCategory == 'All') return debateData;
    return debateData.where((debate) => debate['category'] == selectedCategory).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debate Feed'),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;

                return ChoiceChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  selectedColor: Theme.of(context).primaryColor,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ),
         const  SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              itemCount: filteredDebates.length,
              itemBuilder: (context, index) {
                final debate = filteredDebates[index];
                return Card(
                  margin: const  EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          debate['username'],
                          style: const  TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          debate['opinion'],
                          style: const TextStyle(fontSize: 14),
                        ),
                       const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Likes: ${debate['likes']}'),
                            ElevatedButton(
                              onPressed: () =>  _handleLike(debate),
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
          ),
        ],
      ),
    );
  }
}
