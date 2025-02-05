import 'package:carey/chat_manager.dart';
import 'package:carey/core/errors/failure.dart';
import 'package:carey/features/upload_rx/data/models/upload_rx_model.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

abstract class CareyUploadRxRepository {
  Future<Either<Failure, UploadRxModel>> uploadPrescriptions(
    List<FileAttachmentModel?> files,
    void Function(double progress)? onSendProgress,
    CancelToken? cancelToken,
    String serviceType,
    String uploadType,
  );
}
