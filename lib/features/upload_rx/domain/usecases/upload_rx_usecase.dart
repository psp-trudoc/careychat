import 'package:carey/chat_manager.dart';
import 'package:carey/core/errors/failure.dart';
import 'package:carey/features/upload_rx/data/models/upload_rx_model.dart';
import 'package:carey/features/upload_rx/domain/repositories/upload_rx_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class UploadRxUseCase {
  final UploadRxRepository repository;

  UploadRxUseCase(this.repository);

  Future<Either<Failure, UploadRxModel>> call(
    List<FileAttachmentModel?> files,
    void Function(double progress)? onSendProgress,
    CancelToken? cancelToken,
    String serviceType,
    String uploadType,
  ) async {
    return await repository.uploadPrescriptions(
      files,
      onSendProgress,
      cancelToken,
      serviceType,
      uploadType,
    );
  }
}
