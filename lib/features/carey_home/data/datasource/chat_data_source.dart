import 'dart:ffi';
import 'dart:io';

import 'package:carey/core/constants/app_routes.dart';
import 'package:carey/core/errors/exceptions.dart';
import 'package:carey/core/network/api_client.dart';
import 'package:carey/core/utils/app_utils.dart';
import 'package:carey/features/carey_home/data/model/chat_messages_model.dart';
import 'package:carey/features/carey_home/domain/entities/chat_register_user.dart';
import 'package:carey/features/carey_home/domain/entities/conversation_meta_data.dart';
import 'package:dio/dio.dart';

abstract class ChatDataSource {
  Future<ChatRegisterUserModel> registerUser(String userId, String name);

  Future<Int64> createConversation(String token);

  Future<ConversationMetaData> getConversationMetaData();

  Future<bool> sendMessage(String message);

  Future<ChatMessagesResponseModel> getLatestMessages(
      String conversationId, String type);
}

class ChatDataSourceImpl implements ChatDataSource {
  final APIClient _api;

  ChatDataSourceImpl(this._api);

  @override
  Future<ChatRegisterUserModel> registerUser(String userId, String name) async {
    var jsonData = {
      "user_object_id": "U78853",
      "name": "psp google",
      "hc_name": "kiran",
      "type": "ios",
    };
    print("register user");

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
      "participants": ["U78853", "H4040"],
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
      "userId": "U78853",
      "pageNum": 1,
    };

    print("API call");

    try {
      final response = await _api.postWithHeaders(
          AppRoutes.getConversationMetaData, jsonData,
          token:
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjY1MDE1LCJpYXQiOjE3MzY4NDY1NzJ9.mBrSjYGQj89Zwe-EBOTiKTkvyXW1NubIK_7FoIukZrw");

      print(response.data);

      final List<dynamic> metadata = response.data["metadata"];

      // Get the first object in the metadata list
      final Map<String, dynamic> firstObject = metadata[0];

      // Print the first object
      print(firstObject);

      return ConversationMetaData.fromJson(firstObject);
    } on DioException catch (e) {
      print("exception");
      print(e.response);

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
  Future<bool> sendMessage(String message) async {
    var jsonData = {
      "participants": ["U78853", "H4040"],
      "conversationId": "61436",
      "mimeType": "text/plain",
      "body": message,
      "sender": "U78853",
      "trackId": AppUtils.generateTrackId(),
      "type": "conversation",
      "clientId": "U78853-E970F891-096A-4ECD-B0E3-08FB2C787FA3",
    };

    print(jsonData);

    try {
      final response = await _api.postWithHeaders(
          AppRoutes.sendMessage, jsonData,
          token:
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjY1MDE1LCJpYXQiOjE3MzcwMDQyMzJ9.GnAHuyeMLOn5oJj8pT51a9mV8S6c4zEZs6cohmRKuGw");

      print(response.data);

      return true;
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
  Future<ChatMessagesResponseModel> getLatestMessages(
      String conversationId, String type) async {
    var jsonData = {
      "conversationId": conversationId,
      "type": type,
      "count": 50,
    };

    print(jsonData);

    try {
      final response = await _api.postWithHeaders(
          AppRoutes.getMessages, jsonData,
          token:
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjY1MDE1LCJpYXQiOjE3MzcwMDQyMzJ9.GnAHuyeMLOn5oJj8pT51a9mV8S6c4zEZs6cohmRKuGw");
      print("logs got");

      print(response.data);
      return ChatMessagesResponseModel.fromJson(response.data);
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
