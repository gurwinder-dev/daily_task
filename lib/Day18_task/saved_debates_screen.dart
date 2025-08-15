

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SavedDebatesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SavedDebatesScreen extends StatefulWidget {
  const SavedDebatesScreen({super.key});

  @override
  State<SavedDebatesScreen> createState() => _SavedDebatesScreenState();
}

class _SavedDebatesScreenState extends State<SavedDebatesScreen> {
  final List<Map<String, dynamic>> _allDebates = [
    {'title': 'Climate Change', 'category': 'Environment', 'date': DateTime(2025, 8, 10)},
    {'title': 'AI Ethics', 'category': 'Technology', 'date': DateTime(2025, 8, 12)},
    {'title': 'Free Speech', 'category': 'Politics', 'date': DateTime(2025, 8, 5)},
    {'title': 'Healthcare Reform', 'category': 'Health', 'date': DateTime(2025, 7, 28)},
    {'title': 'Athlete Mental Pressure', 'category': 'Sports', 'date': DateTime(2025, 8, 3)},
  ];

  String _searchQuery = '';
  String _sortOption = 'Newest First';

  List<Map<String, dynamic>> get _filteredDebates {
    List<Map<String, dynamic>> filtered = _allDebates
        .where((debate) =>
        debate['title'].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    switch (_sortOption) {
      case 'Newest First':
        filtered.sort((a, b) => b['date'].compareTo(a['date']));
        break;
      case 'Oldest First':
        filtered.sort((a, b) => a['date'].compareTo(b['date']));
        break;
      case 'Category':
        filtered.sort((a, b) => a['category'].compareTo(b['category']));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Debates',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search by title...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(width: 70,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: DropdownButton<String>(
                  value: _sortOption,
                  underline: Container(),
                  icon: const Icon(Icons.arrow_drop_down),
                  selectedItemBuilder: (context) {
                    return ['Newest First', 'Oldest First', 'Category'].map((_) {
                      return const Text('Sort');
                    }).toList();
                  },
                  items: const [
                    DropdownMenuItem(value: 'Newest First', child: Text('Newest')),
                    DropdownMenuItem(value: 'Oldest First', child: Text('Oldest')),
                    DropdownMenuItem(value: 'Category', child: Text('Category')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _sortOption = value);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
            Expanded(
              child: _filteredDebates.isEmpty
                  ? const Center(child: Text('No results found.'))
                  : ListView.separated(
                itemCount: _filteredDebates.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final debate = _filteredDebates[index];
                  return DebateListItem(
                    title: debate['title'],
                    category: debate['category'],
                    date: debate['date'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DebateListItem extends StatelessWidget {
  final String title;
  final String category;
  final DateTime date;

  const DebateListItem({
    super.key,
    required this.title,
    required this.category,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.chat_bubble_outline),
      title: Text(title),
      subtitle: Text('$category • ${_formatDate(date)}'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
