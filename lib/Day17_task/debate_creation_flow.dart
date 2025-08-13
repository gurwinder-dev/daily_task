

import 'package:flutter/material.dart';

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
      home: DebateCreationFlow(),
    );
  }
}


class DebateCreationFlow extends StatefulWidget {
  @override
  _DebateCreationFlowState createState() => _DebateCreationFlowState();
}

class _DebateCreationFlowState extends State<DebateCreationFlow> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  final _formKey = GlobalKey<FormState>();

  String topic = '';
  String description = '';
  String category = '';

  final List<String> categories = ['Politics', 'Tech', 'Sports', 'Health', 'Education'];

  void nextStep() {
    if (_currentStep == 0 && topic.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Topic cannot be empty')),
      );
      return;
    }

    if (_currentStep == 1 && description.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Description cannot be empty')),
      );
      return;
    }

    if (_currentStep == 2 && category.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category')),
      );
      return;
    }

    if (_currentStep < 3) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    else {
      // DONE PRESSED — show confirmation
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Success ✅"),
          content: Text("Your debate has been created successfully!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                resetForm();
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }
  void resetForm() {
    setState(() {
      topic = '';
      description = '';
      category = '';
      _currentStep = 0;
    });

    _pageController.animateToPage(
      0,
      duration:const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }


  void previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration:const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        bool isActive = index <= _currentStep;
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 12,
          height: 12,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(6),
          ),
        );
      }),
    );
  }

  Widget buildStepButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_currentStep > 0)
          ElevatedButton(
            onPressed: previousStep,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ) ),
            child: const Text('Back'),
          ),
        ElevatedButton(
          onPressed: nextStep,
        style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
    ) ),
          child: Text(_currentStep == 3 ? 'Done' : 'Next'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Debate')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildProgressIndicator(),
            const SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics:const NeverScrollableScrollPhysics(),
                children: [
                  buildTopicStep(),
                  buildDescriptionStep(),
                  buildCategoryStep(),
                  buildSummaryStep(),
                ],
              ),
            ),
            buildStepButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildTopicStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Debate Topic", style: Theme.of(context).textTheme.headline6),
        TextFormField(
          initialValue: topic,
          decoration: const InputDecoration(hintText: 'Enter topic here'),
          onChanged: (value) => topic = value,
        ),
      ],
    );
  }

  Widget buildDescriptionStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Debate Details", style: Theme.of(context).textTheme.headline6),
        TextFormField(
          initialValue: description,
          maxLines: 6,
          decoration: const InputDecoration(hintText: 'Write your opinion or description'),
          onChanged: (value) => description = value,
        ),
      ],
    );
  }

  Widget buildCategoryStep() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Select Category", style: Theme.of(context).textTheme.headline6),
          ...categories.map((cat) {
            return RadioListTile<String>(
              activeColor: Colors.blue,
              title: Text(cat),
              value: cat,
              groupValue: category,
              onChanged: (value) {
                setState(() => category = value!);
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget buildSummaryStep() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Review Your Debate",
            style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 20),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(Icons.topic, color: Colors.blue),
              title: Text("Topic"),
              subtitle: Text(topic),
            ),
          ),
          SizedBox(height: 12),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(Icons.description, color: Colors.teal),
              title: Text("Description"),
              subtitle: Text(description),
            ),
          ),
          SizedBox(height: 12),

          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(Icons.category, color: Colors.deepPurple),
              title: Text("Category"),
              subtitle: Text(category),
            ),
          ),
          const SizedBox(height: 24),
         const Center(
            child:Text(
              "Press 'Done' to finish!",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }}
