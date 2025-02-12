class ChatRegisterUserModel {
  bool newUser;
  int userId;
  int hcId;
  String message;
  String? token;

  ChatRegisterUserModel({
    this.newUser = false,
    required this.userId,
    required this.hcId,
    required this.message,
    this.token,
  });

  factory ChatRegisterUserModel.fromJson(Map<String, dynamic> json) {
    return ChatRegisterUserModel(
      newUser: json['newUser'] ?? false,
      userId: json['user_id'],
      hcId: json['hcId'],
      message: json['message'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'newUser': newUser,
      'user_id': userId,
      'hcId': hcId,
      'message': message,
      'token': token,
    };
  }
}
