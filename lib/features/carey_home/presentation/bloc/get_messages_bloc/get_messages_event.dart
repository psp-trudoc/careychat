part of 'index.dart';

sealed class GetMessagesEvent {}

class GetLatestMessagesEvent extends GetMessagesEvent {
  final String conversationId;
  final String type;

  GetLatestMessagesEvent({required this.conversationId, required this.type});
}

class ReceivedNewMessage extends GetMessagesEvent {
  final ChatMessage message;

  ReceivedNewMessage({required this.message});
}
