import 'dart:ffi';

class ConversationMetaData {
  int? convId;
  int? unreadCount;
  int? lastMessageAt;
  String? status;

  ConversationMetaData({
    this.convId,
    this.unreadCount,
    this.lastMessageAt,
    this.status,
  });

  factory ConversationMetaData.fromJson(Map<String, dynamic> json) {
    return ConversationMetaData(
        convId: json['conv_id'],
        unreadCount: json['unread_count'],
        lastMessageAt: json['last_message_at'],
        status: json['status']);
  }
}
