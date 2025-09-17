import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class MediaAttachmentWidget extends StatefulWidget {
  final Function(List<XFile> images, XFile? video) onChanged;

  const MediaAttachmentWidget({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<MediaAttachmentWidget> createState() => _MediaAttachmentWidgetState();
}

class _MediaAttachmentWidgetState extends State<MediaAttachmentWidget> {
  final List<XFile> _selectedImages = [];
  XFile? _selectedVideo;
  VideoPlayerController? _videoController;

  static const int maxFileSize = 5 * 1024 * 1024; // 5MB

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile>? picked = await _picker.pickMultiImage();
    if (picked != null) {
      for (final image in picked) {
        final file = File(image.path);
        if (await file.length() <= maxFileSize) {
          _selectedImages.add(image);
        } else {
          _showError("Image exceeds 5MB limit: ${image.name}");
        }
      }
      setState(() {});
      widget.onChanged(_selectedImages, _selectedVideo);
    }
  }

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      final file = File(video.path);
      if (await file.length() > maxFileSize) {
        _showError("Video exceeds 5MB limit.");
        return;
      }

      _selectedVideo = video;
      _videoController?.dispose();
      _videoController = VideoPlayerController.file(File(video.path));
      await _videoController!.initialize();
      setState(() {});
      widget.onChanged(_selectedImages, _selectedVideo);
    }
  }

  void _removeImage(int index) {
    _selectedImages.removeAt(index);
    setState(() {});
    widget.onChanged(_selectedImages, _selectedVideo);
  }

  void _removeVideo() {
    _videoController?.dispose();
    _selectedVideo = null;
    _videoController = null;
    setState(() {});
    widget.onChanged(_selectedImages, _selectedVideo);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: _pickImages,
              icon: const Icon(Icons.photo_library),
              label:const Text("Add Images"),
            ),
            ElevatedButton.icon(
              onPressed: _pickVideo,
              icon:const  Icon(Icons.video_library),
              label:const Text("Add Video"),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_selectedImages.isNotEmpty)
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _selectedImages.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: Image.file(
                        File(_selectedImages[index].path),
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 4,
                      top: 4,
                      child: GestureDetector(
                        onTap: () => _removeImage(index),
                        child: const CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.black54,
                          child: Icon(Icons.close, size: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        if (_selectedVideo != null && _videoController != null && _videoController!.value.isInitialized)
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  child: VideoPlayer(_videoController!),
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: GestureDetector(
                    onTap: _removeVideo,
                    child: const CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.close, size: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
