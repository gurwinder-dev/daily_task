import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({Key? key}) : super(key: key);

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<FlSpot> originalData = [
    FlSpot(0, 3),
    FlSpot(1, 4),
    FlSpot(2, 2),
    FlSpot(3, 5),
    FlSpot(4, 3),
    FlSpot(5, 4),
    FlSpot(6, 6),
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animatedSpots = originalData.map((spot) {
      return FlSpot(spot.x, spot.y * _animation.value);
    }).toList();

    return AspectRatio(
      aspectRatio: 1.6,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 7,
          gridData:const FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: 1,
                getTitlesWidget: (value, _) {
                  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  if (value.toInt() >= 0 && value.toInt() < days.length) {
                    return Text(days[value.toInt()], style: const TextStyle(fontSize: 12));
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                reservedSize: 40,
                getTitlesWidget: (value, _) => Text(value.toInt().toString(), style: const TextStyle(fontSize: 12)),
              ),
            ),
            rightTitles:const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: animatedSpots,
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData:const FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          lineTouchData:const LineTouchData(enabled: false),
        ),
      ),
    );
  }
}
