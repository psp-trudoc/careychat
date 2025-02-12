import 'package:carey/features/carey_home/domain/entities/chat_message.dart';

class ChatMessagesResponseModel {
  int? count;
  List<ChatMessage>? messages;

  ChatMessagesResponseModel({this.count, this.messages});

  ChatMessagesResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <ChatMessage>[];
      json['messages'].forEach((v) {
        final msg = ChatMessage.fromJson(v);
        if (msg.type == "conversation") {
          messages!.add(ChatMessage.fromJson(v));
        }
      });
      count = messages?.length ?? 0;
    }
  }
}
