part of 'index.dart';

abstract class GetMessagesState {}

final class GetMessagesInitial extends GetMessagesState {}

final class GetMessagesInProgress extends GetMessagesState {}

final class GetMessagesSuccess extends GetMessagesState {
  final List<types.Message> messages;

  GetMessagesSuccess(this.messages);
}

final class GetNewMessageSuccess extends GetMessagesState {
  final List<types.Message> messages;

  GetNewMessageSuccess(this.messages);
}

final class GetMessagesFailure extends GetMessagesState {
  final String error;

  GetMessagesFailure(this.error);
}

final class ReceivedNewMessageState extends GetMessagesState {
  final ChatMessage message;

  ReceivedNewMessageState(this.message);
}
