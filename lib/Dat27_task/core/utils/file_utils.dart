import 'dart:io';

class FileUtils {
  static const int maxSizeInBytes = 5 * 1024 * 1024;

  static Future<bool> isFileUnderLimit(File file) async {
    return await file.length() <= maxSizeInBytes;
  }
}
