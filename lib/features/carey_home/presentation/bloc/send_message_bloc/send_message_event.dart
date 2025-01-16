part of 'index.dart';

sealed class SendMessageEvent {}

class SendMessage extends SendMessageEvent {
  final ChatMessage msg;

  SendMessage({required this.msg});
}
