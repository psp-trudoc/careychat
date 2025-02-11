import 'package:carey/bootstrap.dart';
import 'package:carey/core/network/mqtt_service.dart';
import 'package:carey/features/carey_home/presentation/bloc/index.dart';
import 'package:carey/features/upload_rx/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatManager {
  static final ChatManager _instance = ChatManager._internal();

  factory ChatManager() => _instance;

  ChatManager._internal();

  bool _isInitialized = false;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  BuildContext? get moduleContext => scaffoldMessengerKey.currentContext;

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
