import 'dart:io';

import 'package:carey/core/constants/app_routes.dart';
import 'package:carey/core/errors/exceptions.dart';
import 'package:carey/core/network/api_client.dart';
import 'package:carey/features/carey_home/domain/entities/chat_user.dart';
import 'package:dio/dio.dart';

abstract class ChatDataSource {
  Future<ChatUser> registerUser(int labId, int packageId);
}

class ChatDataSourceImpl implements ChatDataSource {
  final APIClient _api;

  ChatDataSourceImpl(this._api);

  @override
  Future<ChatUser> registerUser(int labId, int packageId) async {
    try {
      final response = await _api.get(AppRoutes.registerDevice);
      return ChatUser.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == HttpStatus.badRequest) {
        final errorData = e.response!.data;
        final errorMessage = errorData['message'] ?? 'An error occurred';
        throw BadRequest(errorMessage);
      } else {
        throw Exception(e.message);
      }
    }
  }
}
