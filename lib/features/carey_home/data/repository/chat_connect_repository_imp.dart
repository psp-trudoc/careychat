import 'dart:ffi';

import 'package:carey/core/errors/exceptions.dart';
import 'package:carey/core/errors/failure.dart';
import 'package:carey/features/carey_home/data/datasource/chat_data_source.dart';
import 'package:carey/features/carey_home/domain/entities/chat_register_user.dart';
import 'package:carey/features/carey_home/domain/entities/chat_user.dart';
import 'package:carey/features/carey_home/domain/entities/conversation_meta_data.dart';
import 'package:carey/features/carey_home/domain/repository/chat_connect_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChatConnectRepositoryImp extends ChatConnectRepository {
  final ChatDataSource remoteDataSource;

  ChatConnectRepositoryImp(this.remoteDataSource);

  @override
  Future<Either<Failure, ChatRegisterUserModel>> registerUser(
      String userId, String name) async {
    try {
      final user = await remoteDataSource.registerUser(userId, name);
      return Right(user);
    } on BadRequest catch (e) {
      return Left(BadRequestFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on Exception catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Int64>> createConversation(String token) async {
    try {
      final conversationId = await remoteDataSource.createConversation(token);
      return Right(conversationId);
    } on BadRequest catch (e) {
      return Left(BadRequestFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on Exception catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ConversationMetaData>> getConversationMetaData() async {
    try {
      final metaData = await remoteDataSource.getConversationMetaData();
      return Right(metaData);
    } on BadRequest catch (e) {
      return Left(BadRequestFailure(e.toString()));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on Exception catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

}
