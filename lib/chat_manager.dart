import 'dart:convert';

import 'package:carey/bootstrap.dart';
import 'package:carey/core/constants/app_keys.dart';
import 'package:carey/core/network/mqtt_service.dart';
import 'package:carey/features/carey_home/domain/entities/chat_register_user.dart';
import 'package:carey/features/carey_home/presentation/bloc/index.dart';
import 'package:carey/features/upload_rx/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatManager {
  static final ChatManager _instance = ChatManager._internal();

  factory ChatManager() => _instance;

  ChatManager._internal();

  bool _isInitialized = false;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  BuildContext? get moduleContext => scaffoldMessengerKey.currentContext;

  ChatRegisterUserModel? user;

  Future<void> connect(String name, String token) async {
    if (_isInitialized) return;

    await setupInjections();

    getIt<ChatConnectBloc>().add(CreateUserEvent(name: name, token: token));

    // context.read<ChatConnectBloc>().add(GetMetaDataEvent());

    MQTTService().connectChat();

    _isInitialized = true;
  }

  attachmentSelected(List<FileAttachmentModel> files) {
    final chatContext = moduleContext;

    if (chatContext != null) {
      chatContext.read<CareyUploadRxBloc>().add(UploadFileSubmit(files));
    }
  }

  Future<ChatRegisterUserModel?> getUser() async {
    if (user != null) {
      return user;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userJson = prefs.getString(AppKeys.userInfo);
    if (userJson == null) return null;

    final chatUser = ChatRegisterUserModel.fromJson(jsonDecode(userJson));

    user = chatUser;

    return chatUser;
  }
}

class FileAttachmentModel {
  String name;
  String path;
  String link;
  bool isUploaded;

  FileAttachmentModel({
    required this.name,
    required this.path,
    this.link = "",
    this.isUploaded = false,
  });
}
