part of 'index.dart';

sealed class GetMessagesEvent {}

class GetLatestMessagesEvent extends GetMessagesEvent {
  GetLatestMessagesEvent();
}

class GetPreviousMessagesEvent extends GetMessagesEvent {
  final String messageId;

  GetPreviousMessagesEvent({required this.messageId});
}

class ReceivedNewMessage extends GetMessagesEvent {
  final ChatMessage message;

  ReceivedNewMessage({required this.message});
}
