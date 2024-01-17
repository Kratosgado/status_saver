import 'dart:io';

bool isImage(File file) {
  final extension = file.path.split('.').last.toLowerCase();
  if (extension == "png" || extension == "jpg" || extension == "jpeg") {
    return true;
  }
  return false;
}

bool isVideo(File file) {
  final extension = file.path.split('.').last.toLowerCase();
  if (extension == "mp4" || extension == "avi" || extension == "mkv") {
    return true;
  }
  return false;
}
