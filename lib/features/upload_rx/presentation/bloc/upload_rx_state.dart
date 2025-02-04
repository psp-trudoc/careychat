part of 'bloc.dart';

abstract class UploadRxState {
  final UploadRxModel? uploadedFiles;
  final String uploadType;
  final String serviceType;

  UploadRxState({
    this.uploadedFiles,
    this.uploadType = "",
    this.serviceType = "",
  });

  int get uploadedFilesLength => uploadedFiles?.files.length ?? 0;

  String get firstUploadFileName {
    if (uploadedFiles?.files.isNotEmpty == true) {
      return uploadedFiles?.files.first.fileName ?? "";
    } else {
      return "";
    }
  }

  List<FileAttachmentModel> get files =>
      uploadedFiles?.files
          .map((e) => FileAttachmentModel(name: e.fileName, path: e.link))
          .toList() ??
      [];
}

class UploadRxInitial extends UploadRxState {}

class UploadRxLoading extends UploadRxState {
  final double progressLoading;
  final List<FileAttachmentModel?>? selectedFiles;

  UploadRxLoading({
    this.selectedFiles,
    this.progressLoading = 0,
    super.uploadedFiles,
    super.uploadType,
    super.serviceType,
  });

  int get selectedFilesLength => selectedFiles?.length ?? 0;

  String get firstSelectedFileName => selectedFiles?.first?.name ?? "";
}

class UploadRxSuccess extends UploadRxState {
  UploadRxSuccess({
    super.uploadedFiles,
    super.uploadType,
    super.serviceType,
  });
}

class UploadRxFailure extends UploadRxState {
  final String error;

  final String? errorMessage;

  UploadRxFailure(
    this.error, {
    this.errorMessage,
    super.uploadedFiles,
    super.uploadType,
    super.serviceType,
  });
}
