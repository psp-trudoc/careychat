import 'package:carey/core/errors/failure.dart';
import 'package:carey/features/carey_home/domain/entities/chat_message.dart';
import 'package:carey/features/carey_home/domain/repository/chat_connect_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChatMessageUseCase {
  final ChatConnectRepository chatRepository;

  ChatMessageUseCase(this.chatRepository);

  Future<Either<Failure, ChatMessage>> sendMessage(ChatMessage msg) async {
    return await chatRepository.sendMessage(msg);
  }

}
