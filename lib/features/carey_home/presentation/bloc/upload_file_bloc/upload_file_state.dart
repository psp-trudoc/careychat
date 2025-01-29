part of 'index.dart';

abstract class UploadFileState {}

final class UploadFileInitialState extends UploadFileState {}

final class UploadFileStateInProgress extends UploadFileState {}

final class UploadFileStateSuccess extends UploadFileState {
  final String file;

  UploadFileStateSuccess(this.file);
}

final class UploadFileStateFailure extends UploadFileState {
  final String error;

  UploadFileStateFailure(this.error);
}
