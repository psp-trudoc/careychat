part of 'bloc.dart';

abstract class CareyUploadRxEvent {}

class UploadFileSubmit extends CareyUploadRxEvent {
  final List<FileAttachmentModel?> selectedFiles;
  final String uploadModuleDocumentType;
  final String uploadModuleServiceType;
  UploadFileSubmit(
    this.selectedFiles, {
    this.uploadModuleDocumentType = "lab_tests",
    this.uploadModuleServiceType = "labs",
  });
}

class UploadPrescriptionFailureRetry extends CareyUploadRxEvent {
  final List<FileAttachmentModel?> selectedFiles;

  UploadPrescriptionFailureRetry(this.selectedFiles);
}
