import 'dart:ffi';
import 'dart:io';

import 'package:carey/core/constants/app_routes.dart';
import 'package:carey/core/errors/exceptions.dart';
import 'package:carey/core/network/api_client.dart';
import 'package:carey/features/carey_home/domain/entities/chat_register_user.dart';
import 'package:carey/features/carey_home/domain/entities/chat_user.dart';
import 'package:carey/features/carey_home/domain/entities/conversation_meta_data.dart';
import 'package:dio/dio.dart';

abstract class ChatDataSource {
  Future<ChatRegisterUserModel> registerUser(String userId, String name);

  Future<Int64> createConversation(String token);

  Future<ConversationMetaData> getConversationMetaData();
}

class ChatDataSourceImpl implements ChatDataSource {
  final APIClient _api;

  ChatDataSourceImpl(this._api);

  @override
  Future<ChatRegisterUserModel> registerUser(String userId, String name) async {
    var jsonData = {
      "user_object_id": "U79433",
      "name": "psp google",
      "hc_name": "kiran",
      "type": "ios",
    };

    try {
      final response = await _api.postJson(AppRoutes.registerDevice, jsonData);

      return ChatRegisterUserModel.fromJson(response.data);
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

  @override
  Future<Int64> createConversation(String token) async {
    var jsonData = {
      "user_id": "U79433",
      "pageNum": 1,
    };

    try {
      final response =
          await _api.postJson(AppRoutes.registerConversation, jsonData);

      return response.data["conversationId"];
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

  @override
  Future<ConversationMetaData> getConversationMetaData() async {
    var jsonData = {
      "participants": ["U79433", "H4021"],
    };

    try {
      final response =
          await _api.postJson(AppRoutes.getConversationMetaData, jsonData);

      return ConversationMetaData.fromJson(response.data);
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
