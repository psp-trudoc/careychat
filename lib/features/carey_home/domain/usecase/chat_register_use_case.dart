import 'dart:ffi';

import 'package:carey/core/errors/failure.dart';
import 'package:carey/features/carey_home/domain/entities/chat_register_user.dart';
import 'package:carey/features/carey_home/domain/entities/conversation_meta_data.dart';
import 'package:carey/features/carey_home/domain/repository/chat_connect_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChatRegisterUserUseCase {
  final ChatConnectRepository chatRepository;

  ChatRegisterUserUseCase(this.chatRepository);

  Future<Either<Failure, ChatRegisterUserModel>> register(
      String userId, String name) async {
    return await chatRepository.registerUser(userId, name);
  }

  Future<Either<Failure, String>> createConversation(String token) async {
    return await chatRepository.createConversation(token);
  }

  Future<Either<Failure, ConversationMetaData>> getConversationMetaData() async {
    return await chatRepository.getConversationMetaData();
  }

}
