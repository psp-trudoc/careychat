import 'package:carey/features/carey_home/domain/entities/chat_user.dart';
import 'package:carey/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class ChatConnectRepository {
  Future<Either<Failure, ChatUser>> registerUser(String userId, String name);
}
