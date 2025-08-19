
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debate App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home:Scaffold(
        appBar: AppBar(
          title: const Text("Debate Results",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue,
        ),
      body: DebateResultCard(
        topic: "Should smartphones be allowed in classrooms?",
        agreeVotes: 120,
        disagreeVotes: 80,
      ),
    ));
  }
}
class DebateResultCard extends StatelessWidget {
  final String topic;
  final int agreeVotes;
  final int disagreeVotes;

  DebateResultCard({
    required this.topic,
    required this.agreeVotes,
    required this.disagreeVotes,
  });

  @override
  Widget build(BuildContext context) {
    int totalVotes = agreeVotes + disagreeVotes;
    double agreePercentage = totalVotes == 0 ? 0 : agreeVotes / totalVotes;
    double disagreePercentage = totalVotes == 0 ? 0 : disagreeVotes / totalVotes;

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topic,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.indigo),
            ),
            SizedBox(height: 16),
            PieChart(
              dataMap: {
                "Agree": agreeVotes.toDouble(),
                "Disagree": disagreeVotes.toDouble(),
              },
              chartRadius: 150,
              colorList: [Colors.green, Colors.red],
              chartType: ChartType.disc,
              chartValuesOptions:const ChartValuesOptions(
                showChartValuesInPercentage: true,
                showChartValuesOutside: false,
              ),
              legendOptions: LegendOptions(showLegends: true),
            ),

            SizedBox(height: 24),

            _buildVoteRow(
              label: "✅ Agree",
              votes: agreeVotes,
              percentage: agreePercentage,
              color: Colors.green,
            ),
            SizedBox(height: 12),

            _buildVoteRow(
              label: "❌ Disagree",
              votes: disagreeVotes,
              percentage: disagreePercentage,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoteRow({
    required String label,
    required int votes,
    required double percentage,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label - $votes votes', style: TextStyle(fontWeight: FontWeight.w600)),
        SizedBox(height: 6),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: Colors.grey.shade300,
          color: color,
          minHeight: 10,
        ),
        SizedBox(height: 8),
        Row(
          children: List.generate(5,
                (index) => Padding(
              padding: const EdgeInsets.only(right: 4),
              child: CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage('assets/avatar${index % 3 + 1}.png'),
    child: Container(
    decoration:const BoxDecoration(
    shape: BoxShape.circle,
    boxShadow: [
    BoxShadow(
    color: Colors.black26,
    blurRadius: 4,
    offset: Offset(0, 2),
    )
              ]),
            ),
          ),
    )
    ))
    ]);
  }
}
