import 'package:flutter/material.dart';

void main() {
  runApp(LeaderboardApp());
}

class LeaderboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top Debaters',
      home: LeaderboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LeaderboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> users = [
    {"username": "Aman", "score": 120, "rankChange": "up"},
    {"username": "Harsh", "score": 100, "rankChange": "up"},
    {"username": "Gurwinderjit", "score": 90, "rankChange": "up"},
    {"username": "Komal", "score": 80, "rankChange": "down"},
    {"username": "Riya", "score": 70, "rankChange": "down"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text('Top Debaters',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: users.length,
        //separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final user = users[index];
          return LeaderboardCard(
            rank: index + 1,
            username: user['username'],
            score: user['score'],
            rankChange: user['rankChange'],
          );
        },
      ),
    );
  }
}

class LeaderboardCard extends StatefulWidget {
  final int rank;
  final String username;
  final int score;
  final String rankChange;

  const LeaderboardCard({
    Key? key,
    required this.rank,
    required this.username,
    required this.score,
    required this.rankChange,
  }) : super(key: key);

  @override
  _LeaderboardCardState createState() => _LeaderboardCardState();
}

class _LeaderboardCardState extends State<LeaderboardCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    if (widget.rank <= 3) {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),
      )..repeat(reverse: true);
      _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );

      _opacityAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );
    }
  }

  @override
  void dispose() {
    if (widget.rank <= 3) {
      _controller.dispose();
    }
    super.dispose();
  }

  Widget _buildRankIcon() {
    Widget icon;

    switch (widget.rank) {
      case 1:
        icon = Text("👑", style: TextStyle(fontSize: 24));
        break;
      case 2:
        icon = Text("🥈", style: TextStyle(fontSize: 24));
        break;
      case 3:
        icon = Text("🥉", style: TextStyle(fontSize: 24));
        break;
      default:
        return Text("${widget.rank}.", style: TextStyle(fontSize: 18));
    }

    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: icon,
      ),
    );
  }

  Icon _buildRankChangeIcon() {
    switch (widget.rankChange) {
      case "up":
        return Icon(Icons.arrow_upward, color: Colors.green, size: 16);
      case "down":
        return Icon(Icons.arrow_downward, color: Colors.red, size: 16);
      default:
        return Icon(Icons.remove, color: Colors.grey, size: 16);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
          Colors.primaries[widget.rank % Colors.primaries.length],
          child: Text(
            widget.username[0].toUpperCase(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Row(
          children: [
            _buildRankIcon(),
            SizedBox(width: 8),
            Text(widget.username, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        subtitle: Text('${widget.score} pts'),
        trailing: _buildRankChangeIcon(),
      ),
    );
  }
}
