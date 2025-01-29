part of 'index.dart';

sealed class UploadFileEvent {}

class UploadMediaFileEvent extends UploadFileEvent {
  final String fileName;
  final String filePath;

  UploadMediaFileEvent({required this.fileName, required this.filePath});
}
