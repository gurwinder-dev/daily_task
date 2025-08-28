import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({Key? key}) : super(key: key);

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<Map<String, dynamic>> data = [
    {'value': 60.0, 'color': Colors.green, 'title': 'Agree'},
    {'value': 40.0, 'color': Colors.red, 'title': 'Disagree'},
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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
    final total = data.fold(0.0, (sum, item) => sum + (item['value'] as num).toDouble());

    return AspectRatio(
      aspectRatio: 1.3,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 40,
          sectionsSpace: 4,
          sections: data.map((item) {
            final value = (item['value'] as num).toDouble();
            final animatedValue = value * _animation.value;
            final percent = ((animatedValue / total) * 100).toStringAsFixed(0);

            return PieChartSectionData(
              value: animatedValue,
              color: item['color'] as Color,
              title: '${_animation.value == 0 ? '' : '$percent%'}',
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              radius: 60,
            );
          }).toList(),
        ),
      ),
    );
  }
}
