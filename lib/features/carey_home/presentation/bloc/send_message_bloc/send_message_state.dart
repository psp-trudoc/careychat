part of 'index.dart';

abstract class SendMessageState {}

final class SendMessageInitial extends SendMessageState {}

final class SendMessageInProgress extends SendMessageState {}

final class SendMessageSuccess extends SendMessageState {}

final class SendMessageFailure extends SendMessageState {
  final String error;

  SendMessageFailure(this.error);
}
