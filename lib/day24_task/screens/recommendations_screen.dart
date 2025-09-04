import 'package:flutter/material.dart';
import '../models/debate.dart';
import '../widgets/recommended_debate_card.dart';

class RecommendationsScreen extends StatefulWidget {
  @override
  _RecommendationsScreenState createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  final List<Debate> allDebates = [
    Debate(title: "Universal Basic Income", category: "Politics", popularityScore: 92),
    Debate(title: "AI in Warfare", category: "Tech", popularityScore: 88),
    Debate(title: "Climate Policy Reform", category: "Politics", popularityScore: 75),
    Debate(title: "Future of Quantum Computing", category: "Tech", popularityScore: 70),
    Debate(title: "Cancel Culture in Media", category: "Culture", popularityScore: 60),
    Debate(title: "Social Media Regulation", category: "Politics", popularityScore: 85),
    Debate(title: "Ethics of Genetic Editing", category: "Science", popularityScore: 65),
  ];

  final int politicsActivity = 7;
  final int techLikes = 5;

  bool showTrending = false;

  List<Debate> get personalizedRecommendations {
    List<Debate> sorted = List.from(allDebates);

    sorted.sort((a, b) {
      int aScore = a.popularityScore;
      int bScore = b.popularityScore;

      if (a.category == 'Politics') aScore += politicsActivity * 2;
      if (a.category == 'Tech') aScore += techLikes * 2;
      if (b.category == 'Politics') bScore += politicsActivity * 2;
      if (b.category == 'Tech') bScore += techLikes * 2;

      return bScore.compareTo(aScore);
    });

    return sorted;
  }

  List<Debate> get trendingDebates {
    List<Debate> trending = List.from(allDebates);
    trending.sort((a, b) => b.popularityScore.compareTo(a.popularityScore));
    return trending;
  }

  @override
  Widget build(BuildContext context) {
    final currentList = showTrending ? trendingDebates : personalizedRecommendations;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommended Debates for You"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Trending",style: TextStyle(fontSize: 16),),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Transform.scale(
                  scale: 0.75,
                  child: Switch(
                    activeColor: Colors.blue,
                    inactiveThumbColor: Colors.grey,
                    value: showTrending,
                    onChanged: (val) {
                      setState(() => showTrending = val);
                    },
                  ),
                ),
              ),
              const Text("Personalized",style: TextStyle(fontSize: 16),),
              SizedBox(width: 12),
            ],
          ),
          SizedBox(height: 12),
          Expanded(
            child: AnimatedSwitcher(
              duration:const Duration(milliseconds: 500),
              child: ListView.builder(
                key: ValueKey(showTrending),
                padding: EdgeInsets.all(16),
                itemCount: currentList.length,
                itemBuilder: (context, index) {
                  final debate = currentList[index];
            
                  String reason = '';
                  if (debate.popularityScore > 80) {
                    reason = 'Popular with score ${debate.popularityScore}';
                  } else if (debate.category == 'Tech') {
                    reason = 'You liked $techLikes Tech debates';
                  } else if (debate.category == 'Politics') {
                    reason = 'You’re active in Politics topics ($politicsActivity actions)';
                  } else {
                    reason = 'General recommendation';
                  }
            
                  return RecommendedDebateCard(
                    debate: debate,
                    recommendationReason: reason,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
