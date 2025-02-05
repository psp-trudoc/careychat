import 'package:carey/chat_manager.dart';
import 'package:carey/core/errors/exceptions.dart';
import 'package:carey/core/errors/failure.dart';
import 'package:carey/features/upload_rx/data/datasources/upload_rx_remote_data_source.dart';
import 'package:carey/features/upload_rx/data/models/upload_rx_model.dart';
import 'package:carey/features/upload_rx/domain/repositories/upload_rx_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class UploadRxRepositoryImpl extends CareyUploadRxRepository {
  final CareyUploadRxDataSource remoteDataSource;

  UploadRxRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UploadRxModel>> uploadPrescriptions(
    List<FileAttachmentModel?> files,
    void Function(double progress)? onSendProgress,
    CancelToken? cancelToken,
    String serviceType,
    String uploadType,
  ) async {
    try {
      final uploadResponse = await remoteDataSource.uploadPrescriptions(
        files,
        onSendProgress,
        cancelToken,
        serviceType,
        uploadType,
      );
      return Right(uploadResponse);
    } on BadRequest catch (e) {
      return Left(BadRequestFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
