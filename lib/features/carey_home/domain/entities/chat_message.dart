class ChatMessage {
  String trackId;
  int id;
  String type;
  String sender;
  String? clientId;
  String? topic;
  String? body;
  String mimeType;
  bool isSent;
  String? senderName;
  String? conversationId;

  ChatMessage({
    required this.trackId,
    required this.id,
    required this.type,
    required this.sender,
    this.clientId,
    this.topic,
    this.body,
    required this.mimeType,
    required this.isSent,
    this.senderName,
    this.conversationId,
  });

  bool get isMine => sender == "U79433";

  DateTime get timestamp => DateTime.now();

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      trackId: json['trackId'],
      id: json['id'],
      type: json['type'],
      sender: json['sender'],
      clientId: json['clientId'],
      topic: json['topic'],
      body: json['body'],
      mimeType: json['mimeType'],
      isSent: json['isSent'],
      senderName: json['senderName'],
    );
  }
}
