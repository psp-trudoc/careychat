part of 'bloc.dart';

abstract class CareyUploadRxState {
  final UploadRxModel? uploadedFiles;
  final String uploadType;
  final String serviceType;

  CareyUploadRxState({
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

class UploadRxInitial extends CareyUploadRxState {}

class UploadRxLoading extends CareyUploadRxState {
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

class UploadRxSuccess extends CareyUploadRxState {
  UploadRxSuccess({
    super.uploadedFiles,
    super.uploadType,
    super.serviceType,
  });
}

class UploadRxFailure extends CareyUploadRxState {
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
