import 'package:flutter/material.dart';
import '../services/auto_save_service.dart';
import '../models/draft_model.dart';
import '../utils/time_utils.dart';
import 'new_debate_screen.dart';

class DraftsScreen extends StatefulWidget {
  const DraftsScreen({super.key});

  @override
  State<DraftsScreen> createState() => _DraftsScreenState();
}

class _DraftsScreenState extends State<DraftsScreen> {
  List<DraftModel> drafts = [];

  @override
  void initState() {
    super.initState();
    _loadDrafts();
  }

  void _loadDrafts() async {
    final data = await AutoSaveService.getAllDrafts();
    data.sort((a, b) => b.lastEdited.compareTo(a.lastEdited));
    setState(() => drafts = data);
  }

  void _deleteDraft(String id) async {
    await AutoSaveService.deleteDraft(id);
    _loadDrafts();
  }

  void _editDraft(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => NewDebateScreen(draftId: id)),
    ).then((_) => _loadDrafts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Drafts")),
      body: drafts.isEmpty
          ? const Center(child: Text("No drafts yet"))
          : ListView.builder(
        itemCount: drafts.length,
        itemBuilder: (context, index) {
          final draft = drafts[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              child: ListTile(
                title: Text(draft.title.isEmpty ? "(No title)" : draft.title),
                subtitle: Text("Last edited: ${timeAgo(draft.lastEdited)}"),
                onTap: () => _editDraft(draft.id),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteDraft(draft.id),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
