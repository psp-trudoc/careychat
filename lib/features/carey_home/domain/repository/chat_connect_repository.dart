import 'dart:ffi';

import 'package:carey/features/carey_home/domain/entities/chat_register_user.dart';
import 'package:carey/core/errors/failure.dart';
import 'package:carey/features/carey_home/domain/entities/conversation_meta_data.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

abstract class ChatConnectRepository {
  Future<Either<Failure, ChatRegisterUserModel>> registerUser(
      String userId, String name);

  Future<Either<Failure, String>> createConversation();

  Future<Either<Failure, ConversationMetaData>> getConversationMetaData();

  Future<Either<Failure, bool>> sendMessage(String message);

  Future<Either<Failure, List<types.Message>>> getLatestMessages(String type);
}
