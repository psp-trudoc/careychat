import 'package:carey/core/errors/failure.dart';
import 'package:carey/features/carey_home/domain/entities/chat_user.dart';
import 'package:carey/features/carey_home/domain/repository/chat_connect_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChatRegisterUserUseCase {
  final ChatConnectRepository chatRepository;

  ChatRegisterUserUseCase(this.chatRepository);

  Future<Either<Failure, ChatUser>> call(String userId, String name) async {
    return await chatRepository.registerUser(userId, name);
  }
}
