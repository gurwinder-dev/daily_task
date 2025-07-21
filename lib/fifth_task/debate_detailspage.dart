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
      home: DebateDetailsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}



class DebateDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Debate"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [

            Text(
              "Is Remote Work More Productive Than Office Work?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage("assets/profile-picture.png"), // Replace with your asset
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Simar Amritsar",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "@simaramritsar • July 21, 2025 – 2:00 PM",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            Text(
              "With the rise of remote work, many argue that it increases productivity by reducing distractions and commute times. Others believe in-person collaboration drives innovation and accountability. What do you think is the future of work?",
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
              ),
            ),
            SizedBox(height: 20),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border, color: Colors.red),
                  label: Text("Like"),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.comment_outlined),
                  label: Text("Comment"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
