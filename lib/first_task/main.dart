import 'package:flutter/material.dart';
import '../fifth_task/debate_detailspage.dart';
import '../fourth_task/debate_feed.dart';
import '../seventh_task/debate_screen.dart';

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
      home: MainScreen(),
    );
  }
}
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}
int myIndex = 0;
List<Widget> widgetlist=[
  HeaticDebateFeed(),
  DebateScreen(),
  DebateDetailsPage(),
];

class _MainScreenState extends State<MainScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: myIndex,
        children: widgetlist,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myIndex,
        onTap: (index){
          setState(() {
            myIndex=index;
          });
        },

        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Create Debate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
