part of 'index.dart';

abstract class GetMessagesState {}

final class GetMessagesInitial extends GetMessagesState {}

final class GetMessagesInProgress extends GetMessagesState {}

final class GetMessagesSuccess extends GetMessagesState {
  final List<types.Message> messages;

  GetMessagesSuccess(this.messages);
}

final class GetMessagesFailure extends GetMessagesState {
  final String error;

  GetMessagesFailure(this.error);
}
