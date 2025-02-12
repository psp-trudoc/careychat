import 'package:carey/chat_manager.dart';
import 'package:carey/core/utils/app_utils.dart';
import 'package:carey/core/widgets/app_bar.dart';
import 'package:carey/features/carey_home/domain/entities/chat_register_user.dart';
import 'package:carey/features/carey_home/presentation/bloc/get_messages_bloc/index.dart';
import 'package:carey/features/carey_home/presentation/bloc/send_message_bloc/index.dart';
import 'package:carey/features/carey_home/presentation/widgets/carey_input_bar_widget.dart';
import 'package:carey/features/upload_rx/presentation/bloc/bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class CareyHomePage extends StatefulWidget {
  const CareyHomePage({super.key, this.onAttachmentTap});

  final GestureTapCallback? onAttachmentTap;

  @override
  CareyHomePageState createState() => CareyHomePageState();
}

class CareyHomePageState extends State<CareyHomePage> {
  List<types.Message> _messages = [];

  late types.User _user;

  @override
  void initState() {
    super.initState();

    loadUser();

    loadLatestMessages();
  }

  loadUser() async {
    ChatRegisterUserModel? user = await ChatManager().getUser();

    String userID = user?.userId.toString() ?? "";

    _user = types.User(
      id: 'U$userID',
    );
  }

  loadLatestMessages() {
    context.read<GetMessagesBloc>().add(GetLatestMessagesEvent());
  }

  _handleAttachmentPressed() {}

  _handleMessageTap(BuildContext _, types.Message message) async {
    print("_handleMessageTap");
  }

  _handlePreviewDataFetched(
      types.TextMessage message, types.PreviewData previewData) {
    print("_handlePreviewDataFetched");
  }

  _handleSendPressed(types.PartialText message) {}

  Future<void> _handlePagination() async {
    if (_messages.isEmpty) {
      return;
    }
    print("pagination !!!!!!!!!!!!!!!!");

    String msgID = _messages.last.id;

    context
        .read<GetMessagesBloc>()
        .add(GetPreviousMessagesEvent(messageId: msgID));
  }

  sendMessage(String msg) {
    if (msg.isNotEmpty) {
      final newMessage = types.TextMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: AppUtils.generateTrackId(),
        text: msg,
      );

      setState(() {
        _messages.insert(0, newMessage);
      });

      context.read<SendMessageBloc>().add(
            SendTextMessage(
              msg: msg,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        key: ChatManager().scaffoldMessengerKey,
        appBar: const CareyAppBar(
          title: "Carey",
        ),
        body: BlocConsumer<GetMessagesBloc, GetMessagesState>(
          builder: buildChat,
          listener: (BuildContext context, GetMessagesState state) {
            print("new msg received 22");
            print(state);

            if (state is ReceivedNewMessageState) {}
          },
        ),
      );

  Widget buildChat(BuildContext context, GetMessagesState state) {
    if (state is GetMessagesInProgress) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (state is GetMessagesSuccess) {
      _messages = state.messages;

      return buildChatUI();
    } else if (state is ReceivedNewMessageState) {
      final sender = types.User(id: state.message.sender);

      final newMessage = types.TextMessage(
        author: sender,
        createdAt: state.message.timestamp,
        id: state.message.trackId,
        text: state.message.body ?? "",
      );

      _messages.insert(0, newMessage); // Add new message to the top

      return buildChatUI();
    } else {
      return const SizedBox.shrink();
    }
  }

  Chat buildChatUI() {
    return Chat(
      messages: _messages,
      onAttachmentPressed: _handleAttachmentPressed,
      onPreviewDataFetched: _handlePreviewDataFetched,
      onSendPressed: _handleSendPressed,
      showUserAvatars: false,
      showUserNames: true,
      user: _user,
      customBottomWidget: buildBottomBar(),
      onEndReached: _handlePagination,
    );
  }

  Widget buildBottomBar() {
    return Stack(
      children: [
        CareyInputBarWidget(
          onSend: (String msg) {
            sendMessage(msg);
          },
          onAttachmentTap: widget.onAttachmentTap,
        ),
        BlocListener<CareyUploadRxBloc, CareyUploadRxState>(
          listener: (context, state) {
            if (state is UploadRxSuccess) {
              for (var file in state.files) {
                final newMessage = types.ImageMessage(
                  author: _user,
                  createdAt: DateTime.now().millisecondsSinceEpoch,
                  id: AppUtils.generateTrackId(),
                  uri: file.link,
                  name: 'new message',
                  size: 1000,
                );

                setState(() {
                  _messages.insert(0, newMessage);
                });
              }
            }
          },
          child: const SizedBox(
            height: 1,
          ),
        ),
      ],
    );
  }
}
