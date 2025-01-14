import 'dart:ffi';

import 'package:carey/features/carey_home/domain/entities/chat_register_user.dart';
import 'package:carey/core/errors/failure.dart';
import 'package:carey/features/carey_home/domain/entities/conversation_meta_data.dart';
import 'package:fpdart/fpdart.dart';

abstract class ChatConnectRepository {
  Future<Either<Failure, ChatRegisterUserModel>> registerUser(String userId, String name);
  Future<Either<Failure, Int64>> createConversation(String token);
  Future<Either<Failure, ConversationMetaData>> getConversationMetaData();
}
