import 'package:image_picker/image_picker.dart';

class MediaAttachment {
  final List<XFile> images;
  final XFile? video;

  MediaAttachment({
    required this.images,
    required this.video,
  });
}
