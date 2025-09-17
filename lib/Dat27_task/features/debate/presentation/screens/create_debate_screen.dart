import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/media_attachment_widget.dart';

class CreateDebateScreen extends StatefulWidget {
  const CreateDebateScreen({super.key});

  @override
  State<CreateDebateScreen> createState() => _CreateDebateScreenState();
}

class _CreateDebateScreenState extends State<CreateDebateScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<XFile> _attachedImages = [];
  XFile? _attachedVideo;

  void _onMediaChanged(List<XFile> images, XFile? video) {
    setState(() {
      _attachedImages = images;
      _attachedVideo = video;
    });
  }

  void _submitDebate() {
    print("Title: ${_titleController.text}");
    print("Description: ${_descriptionController.text}");
    print("Images: ${_attachedImages.map((e) => e.path)}");
    print("Video: ${_attachedVideo?.path}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Debate")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Debate Title"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            const SizedBox(height: 20),
            MediaAttachmentWidget(
              onChanged: _onMediaChanged,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitDebate,
              child: const Text("Post Debate"),
            ),
          ],
        ),
      ),
    );
  }
}
