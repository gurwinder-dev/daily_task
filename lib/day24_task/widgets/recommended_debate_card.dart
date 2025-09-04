import 'package:flutter/material.dart';
import '../models/debate.dart';

class RecommendedDebateCard extends StatelessWidget {
  final Debate debate;
  final String recommendationReason;

  const RecommendedDebateCard({
    super.key,
    required this.debate,
    required this.recommendationReason,
  });

  @override
  Widget build(BuildContext context) {
    final isTrending = debate.popularityScore > 80;

    return AnimatedContainer(
      duration:const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding:const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(debate.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(debate.category),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Tooltip(
                message: recommendationReason,
                child:const Icon(Icons.info_outline, size: 20),
              ),
            ),
            Container(
              padding:const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isTrending ? Colors.orange.shade100 : Colors.blue.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isTrending ? '🔥 Trending' : '⭐ Based on your interests',
                style:const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
