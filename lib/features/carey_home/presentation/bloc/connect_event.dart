part of 'index.dart';

sealed class ChatConnectEvent {}

class CreateUserEvent extends ChatConnectEvent {
  final String userId;
  final String name;
  final String hcName;

  CreateUserEvent(
      {required this.userId, required this.name, required this.hcName});
}
