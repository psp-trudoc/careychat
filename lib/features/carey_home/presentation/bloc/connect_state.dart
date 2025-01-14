part of 'index.dart';

abstract class ChatConnectState {}

final class ChatConnectInitial extends ChatConnectState {}

final class ChatConnectInProgress extends ChatConnectState {}

final class ChatConnectSuccess extends ChatConnectState {
  final Int64 conversation;

  ChatConnectSuccess(this.conversation);
}

final class ChatConnectFailure extends ChatConnectState {
  final String error;

  ChatConnectFailure(this.error);
}

final class ChatConnectSyncMetaDataInProgress extends ChatConnectState {}

final class ChatConnectSyncMetaDataSuccess extends ChatConnectState {
  final ConversationMetaData metaData;

  ChatConnectSyncMetaDataSuccess(this.metaData);
}
