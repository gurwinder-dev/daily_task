import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../services/auto_save_service.dart';
import '../utils/time_utils.dart';

class NewDebateScreen extends StatefulWidget {
  final String? draftId;

  const NewDebateScreen({super.key, this.draftId});

  @override
  State<NewDebateScreen> createState() => _NewDebateScreenState();
}

class _NewDebateScreenState extends State<NewDebateScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late AutoSaveService autoSaveService;
  DateTime? lastSaved;

  @override
  void initState() {
    super.initState();
    final id = widget.draftId ?? const Uuid().v4();
    autoSaveService = AutoSaveService(id);
    if (widget.draftId != null) {
      _loadDraft(id);
    }
    titleController.addListener(_onChanged);
    descriptionController.addListener(_onChanged);
  }

  void _onChanged() {
    autoSaveService.autoSave(
      title: titleController.text,
      description: descriptionController.text,
      onSaved: () {
        setState(() => lastSaved = DateTime.now());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Draft saved ✅"),
            duration: Duration(seconds: 1),
          ),
        );
      },
    );
  }

  void _loadDraft(String id) async {
    final draft = await AutoSaveService.getDraftById(id);
    if (draft != null) {
      titleController.text = draft.title;
      descriptionController.text = draft.description;
      setState(() => lastSaved = draft.lastEdited);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    autoSaveService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timestamp = lastSaved != null ? "Last edited: ${timeAgo(lastSaved!)}" : "";
    return Scaffold(
      appBar: AppBar(title: const Text("New Debate")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: descriptionController,
                  maxLines: 6,
                  decoration: const InputDecoration(labelText: "Description"),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  timestamp,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
