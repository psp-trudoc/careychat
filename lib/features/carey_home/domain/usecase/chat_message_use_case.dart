import 'package:carey/core/errors/failure.dart';
import 'package:carey/features/carey_home/domain/repository/chat_connect_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatMessageUseCase {
  final ChatConnectRepository chatRepository;

  ChatMessageUseCase(this.chatRepository);

  Future<Either<Failure, bool>> sendMessage(String msg) async {
    return await chatRepository.sendMessage(msg);
  }

  Future<Either<Failure, List<types.Message>>> getLatestMessages() async {
    return await chatRepository.getLatestMessages();
  }

  Future<Either<Failure, List<types.Message>>> getPreviousMessages(String messageId) async {
    return await chatRepository.getPreviousMessages(messageId);
  }

}
