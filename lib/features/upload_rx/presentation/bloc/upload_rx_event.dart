part of 'bloc.dart';

abstract class UploadRxEvent {}

class UploadPrescriptionSubmit extends UploadRxEvent {
  final List<FileAttachmentModel?> selectedFiles;
  final String uploadModuleDocumentType;
  final String uploadModuleServiceType;
  UploadPrescriptionSubmit(
    this.selectedFiles, {
    this.uploadModuleDocumentType = "",
    this.uploadModuleServiceType = "",
  });
}

class UploadPrescriptionFailureRetry extends UploadRxEvent {
  final List<FileAttachmentModel?> selectedFiles;

  UploadPrescriptionFailureRetry(this.selectedFiles);
}
