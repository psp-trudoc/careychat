import 'dart:io';

import 'package:carey/bootstrap.dart';
import 'package:carey/chat_manager.dart';
import 'package:carey/core/constants/app_keys.dart';
import 'package:carey/core/constants/app_routes.dart';
import 'package:carey/core/errors/exceptions.dart';
import 'package:carey/core/network/api_client.dart';
import 'package:carey/core/utils/app_pref_service.dart';
import 'package:carey/core/utils/app_utils.dart';
import 'package:carey/features/carey_home/data/model/chat_messages_model.dart';
import 'package:carey/features/carey_home/domain/entities/chat_register_user.dart';
import 'package:carey/features/carey_home/domain/entities/conversation_meta_data.dart';
import 'package:dio/dio.dart';

abstract class ChatDataSource {
  Future<ChatRegisterUserModel> registerUser(String userId, String name);

  Future<String> createConversation();

  Future<ConversationMetaData> getConversationMetaData();

  Future<bool> sendMessage(String message);

  Future<ChatMessagesResponseModel> getLatestMessages();

  Future<ChatMessagesResponseModel> getPreviousMessages(String messageId);
}

class ChatDataSourceImpl implements ChatDataSource {
  final APIClient _api;
  final prefs = getIt<AppPreferenceService>();

  ChatDataSourceImpl(this._api);

  @override
  Future<ChatRegisterUserModel> registerUser(String name, String token) async {
    var jsonData = {
      "name": name,
      "role": "patient",
      "type": "ios",
    };
    print("register user");

    try {
      final response = await _api
          .postWithHeaders(AppRoutes.registerUser, jsonData, token: token);

      final userData = ChatRegisterUserModel.fromJson(response.data);

      await prefs.saveJsonObject(AppKeys.userInfo, userData.toJson());

      if (userData.token!.isNotEmpty) {
        prefs.setString(AppKeys.token, userData.token!);
      }

      return userData;
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
  Future<String> createConversation() async {
    ChatRegisterUserModel? user = await ChatManager().getUser();

    String userID = user?.userId.toString() ?? "";
    String hcID = user?.hcId.toString() ?? "";

    var jsonData = {
      "participants": ["U$userID", "H$hcID"],
    };

    try {
      final response = await _api.postWithHeaders(
          AppRoutes.registerConversation, jsonData,
          token: prefs.getString(AppKeys.token));

      final conversationId = response.data["conversationId"].toString();

      prefs.setString(AppKeys.conversationId, conversationId);

      return conversationId;
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
    ChatRegisterUserModel? user = await ChatManager().getUser();

    String userID = user?.userId.toString() ?? "";

    var jsonData = {
      "userId": "U$userID",
      "pageNum": 1,
    };

    print("API call");

    try {
      final response = await _api.postWithHeaders(
          AppRoutes.getConversationMetaData, jsonData,
          token: prefs.getString(AppKeys.token));

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
    ChatRegisterUserModel? user = await ChatManager().getUser();

    String userID = user?.userId.toString() ?? "";
    String hcID = user?.hcId.toString() ?? "";
    String conversationId = prefs.getString(AppKeys.conversationId);

    var jsonData = {
      "participants": ["U$userID", "H$hcID"],
      "conversationId": conversationId,
      "mimeType": "text/plain",
      "body": message,
      "sender": "U$userID",
      "trackId": AppUtils.generateTrackId(),
      "type": "conversation",
      "clientId": "U78853-E970F891-096A-4ECD-B0E3-08FB2C787FA3",
    };

    print(jsonData);

    try {
      final response = await _api.postWithHeaders(
          AppRoutes.sendMessage, jsonData,
          token: prefs.getString(AppKeys.token));

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
  Future<ChatMessagesResponseModel> getLatestMessages() async {
    String conversationId = prefs.getString(AppKeys.conversationId);

    var jsonData = {
      "conversationId": conversationId,
      "type": "latestWithConversationId",
      "count": 50,
    };

    try {
      final response = await _api.postWithHeaders(
          AppRoutes.getMessages, jsonData,
          token: prefs.getString(AppKeys.token));
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

  @override
  Future<ChatMessagesResponseModel> getPreviousMessages(
      String messageId) async {
    String conversationId = prefs.getString(AppKeys.conversationId);

    var jsonData = {
      "conversationId": conversationId,
      "type": "withConvAndMessageId",
      "fromId": messageId,
      "direction": "greaterThan",
      "count": 50,
    };

    try {
      final response = await _api.postWithHeaders(
          AppRoutes.getMessages, jsonData,
          token: prefs.getString(AppKeys.token));
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
