part of 'index.dart';

sealed class ChatConnectEvent {}

class CreateUserEvent extends ChatConnectEvent {
  final String name;
  final String token;

  CreateUserEvent({required this.name, required this.token});
}

class GetMetaDataEvent extends ChatConnectEvent {}
