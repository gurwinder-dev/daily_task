
import 'package:flutter/material.dart';
import 'Widgets/AnalyticsCard.dart';
import 'Widgets/BarChart.dart';
import 'Widgets/LineChart.dart';
import 'Widgets/PieChart.dart';

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
      home: DebateInsightsScreen(),
    );
  }
}


class DebateInsightsScreen extends StatefulWidget {
  @override
  _DebateInsightsScreenState createState() => _DebateInsightsScreenState();
}

class _DebateInsightsScreenState extends State<DebateInsightsScreen>
    with TickerProviderStateMixin {
  int _selectedTab = 0;
  String _selectedFilter = "Last 7 days";

  final List<String> filters = ["Last 7 days", "Last 30 days"];

  final List<Tab> tabs = [
    const Tab(text: 'Overview'),
   const  Tab(text: 'Categories'),
   const  Tab(text: 'Trends'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title:const Text("Debate Insights"),
          bottom: TabBar(tabs: tabs, onTap: (i) => setState(() => _selectedTab = i)),
          actions: [
            DropdownButton<String>(
              value: _selectedFilter,
              underline:const SizedBox(),
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
              },
              items: filters.map((filter) {
                return DropdownMenuItem(
                  value: filter,
                  child: Text(filter),
                );
              }).toList(),
            ),
           const SizedBox(width: 16),
          ],
        ),
        body: TabBarView(
          children: [
            _buildOverviewTab(),
            _buildCategoriesTab(),
            _buildTrendsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding:const EdgeInsets.all(16),
      child: Column(
        children: [
         const Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              AnalyticsCard(title: "Total Debates", value: "12"),
              AnalyticsCard(title: "Total Replies", value: "45"),
              AnalyticsCard(title: "Most Active Category", value: "Politics"),
              AnalyticsCard(title: "Avg Votes per Debate", value: "30"),
            ],
          ),
          const SizedBox(height: 24),
          Text("Vote Distribution", style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: PieChartWidget(key: ValueKey(_selectedFilter)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab() {
    return Padding(
      padding:const EdgeInsets.all(16),
      child: Column(
        children: [
          Text("Debates Per Category", style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 16),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: BarChartWidget(key: ValueKey(_selectedFilter)),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendsTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text("Activity Trend (Last 7 Days)", style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 16),
          AnimatedSwitcher(
            duration:const Duration(milliseconds: 500),
            child: LineChartWidget(key: ValueKey(_selectedFilter)),
          ),
        ],
      ),
    );
  }
}
