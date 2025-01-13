import 'package:carey/core/errors/failure.dart';
import 'package:carey/features/carey_home/data/datasource/chat_data_source.dart';
import 'package:carey/features/carey_home/domain/entities/chat_user.dart';
import 'package:carey/features/carey_home/domain/repository/chat_connect_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChatConnectRepositoryImp extends ChatConnectRepository {
  final ChatDataSource remoteDataSource;

  ChatConnectRepositoryImp(this.remoteDataSource);

  @override
  Future<Either<Failure, ChatUser>> registerUser(String userId, String name) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }
}
