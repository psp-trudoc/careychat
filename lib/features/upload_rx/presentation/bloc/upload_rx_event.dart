part of 'bloc.dart';

abstract class CareyUploadRxEvent {}

class UploadFileSubmit extends CareyUploadRxEvent {
  final List<FileAttachmentModel?> selectedFiles;
  final String uploadModuleDocumentType;
  final String uploadModuleServiceType;
  UploadFileSubmit(
    this.selectedFiles, {
    this.uploadModuleDocumentType = "",
    this.uploadModuleServiceType = "",
  });
}

class UploadPrescriptionFailureRetry extends CareyUploadRxEvent {
  final List<FileAttachmentModel?> selectedFiles;

  UploadPrescriptionFailureRetry(this.selectedFiles);
}
