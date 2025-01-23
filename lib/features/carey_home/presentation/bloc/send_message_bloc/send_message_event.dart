part of 'index.dart';

sealed class SendMessageEvent {}

class SendTextMessage extends SendMessageEvent {
  final String msg;

  SendTextMessage({required this.msg});
}
