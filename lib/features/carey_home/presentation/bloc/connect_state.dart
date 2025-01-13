part of 'index.dart';

abstract class ChatConnectState {}

final class ChatConnectInitial extends ChatConnectState {}

final class ChatConnectInProgress extends ChatConnectState {}

final class ChatConnectSuccess extends ChatConnectState {}

final class ChatConnectFailure extends ChatConnectState {}
