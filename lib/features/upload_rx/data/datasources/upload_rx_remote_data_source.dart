import 'dart:async';
import 'dart:io';

import 'package:carey/chat_manager.dart';
import 'package:carey/core/constants/app_routes.dart';
import 'package:carey/core/errors/exceptions.dart';
import 'package:carey/core/network/api_client.dart';
import 'package:dio/dio.dart';
import 'package:carey/features/upload_rx/data/models/upload_rx_model.dart';

abstract class CareyUploadRxDataSource {
  Future<UploadRxModel> uploadPrescriptions(
    List<FileAttachmentModel?> files,
    void Function(double progress)? onSendProgress,
    CancelToken? cancelToken,
    String serviceType,
    String uploadType,
  );
}

class CareyUploadRxDataSourceImpl implements CareyUploadRxDataSource {
  final APIClient _api;

  CareyUploadRxDataSourceImpl(this._api);

  @override
  Future<UploadRxModel> uploadPrescriptions(
    List<FileAttachmentModel?> files,
    void Function(double progress)? onSendProgress,
    CancelToken? cancelToken,
    String serviceType,
    String uploadType,
  ) async {
    var formData = FormData();
    for (var file in files) {
      if (file != null && file.isUploaded == false) {
        formData.files.add(
          MapEntry(
            "files",
            await MultipartFile.fromFile(
              file.path,
              filename: file.name,
            ),
          ),
        );
      }
    }

    if (formData.files.isEmpty) {
      return UploadRxModel.fromJson({"files": []});
    }
    formData.fields.add(
      MapEntry(
        "service",
        serviceType,
      ),
    );
    formData.fields.add(
      MapEntry(
        "file_type",
        uploadType,
      ),
    );

    try {
      final response = await _api.postFormData(
        AppRoutes.uploadFile,
        formData,
        onSendProgress: (int send, int recieve) {
          if (onSendProgress != null) {
            onSendProgress(((send / recieve) * 100));
          }
        },
        cancelToken: cancelToken,
      );

      return UploadRxModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == HttpStatus.tooManyRequests) {
        final errorData = e.response!.data;
        final errorMessage = errorData['message'] ?? 'An error occurred';
        throw BadRequest(errorMessage);
      } else {
        throw Exception(e.message);
      }
    }
  }
}
