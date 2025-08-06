import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: DebatePollScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class DebatePollScreen extends StatelessWidget {
  const DebatePollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const Center(
        child: DebatePollCard(
          statement: "AI will do more harm than good in the future.",
          initialAgree: 110,
          initialDisagree: 80,
        ),
      ),
    );
  }
}

class DebatePollCard extends StatefulWidget {
  final String statement;
  final int initialAgree;
  final int initialDisagree;

  const DebatePollCard({
    super.key,
    required this.statement,
    this.initialAgree = 100,
    this.initialDisagree = 50,
  });

  @override
  State<DebatePollCard> createState() => _DebatePollCardState();
}

class _DebatePollCardState extends State<DebatePollCard> {
  String? selectedOption;
  late int agreeVotes;
  late int disagreeVotes;

  @override
  void initState() {
    super.initState();
    agreeVotes = widget.initialAgree;
    disagreeVotes = widget.initialDisagree;
  }

  void _handleVote(String option) {
    if (selectedOption != null) return;

    setState(() {
      selectedOption = option;
      if (option == 'agree') {
        agreeVotes++;
      } else {
        disagreeVotes++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final voted = selectedOption != null;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.statement,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildVoteButton(
                  label: 'Agree',
                  icon: Icons.check,
                  color: Colors.green,
                  count: agreeVotes,
                  isSelected: selectedOption == 'agree',
                  onPressed: voted ? null : () => _handleVote('agree'),
                ),
                _buildVoteButton(
                  label: 'Disagree',
                  icon: Icons.close,
                  color: Colors.red,
                  count: disagreeVotes,
                  isSelected: selectedOption == 'disagree',
                  onPressed: voted ? null : () => _handleVote('disagree'),
                ),
              ],
            ),

            if (voted) ...[
              const SizedBox(height: 16),
              _buildThankYouMessage(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildVoteButton({
    required String label,
    required IconData icon,
    required Color color,
    required int count,
    required bool isSelected,
    required VoidCallback? onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text('$label ($count)'),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? color : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildThankYouMessage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.thumb_up, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Text(
            'Thanks for voting!',
            style: TextStyle(
              color: Colors.green[800],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
