import 'package:carey/chat_manager.dart';
import 'package:carey/core/network/mqtt_service.dart';
import 'package:carey/core/utils/app_utils.dart';
import 'package:carey/core/widgets/app_bar.dart';
import 'package:carey/features/carey_home/presentation/bloc/get_messages_bloc/index.dart';
import 'package:carey/features/carey_home/presentation/bloc/index.dart';
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

  final _user = const types.User(
    id: 'U78853',
  );

  @override
  void initState() {
    super.initState();

    context
        .read<ChatConnectBloc>()
        .add(CreateUserEvent(userId: "abv", name: "name", hcName: "hcName"));

    // context.read<ChatConnectBloc>().add(GetMetaDataEvent());

    MQTTService().connectChat();

    loadHistory();
  }

  loadHistory() {
    print("loadHistory");

    context.read<GetMessagesBloc>().add(GetLatestMessagesEvent(
        conversationId: "61436", type: "latestWithConversationId"));
  }

  _handleAttachmentPressed() {
    const hc = types.User(
      id: 'H4040',
    );

    final newMessage = types.TextMessage(
      author: hc,
      createdAt: DateTime
          .now()
          .millisecondsSinceEpoch,
      id: AppUtils.generateTrackId(),
      text: "Halo mike check",
    );

    setState(() {
      _messages.insert(0, newMessage);
    });
  }

  _handleMessageTap(BuildContext _, types.Message message) async {
    print("_handleMessageTap");
  }

  _handlePreviewDataFetched(types.TextMessage message,
      types.PreviewData previewData) {
    print("_handlePreviewDataFetched");
  }

  _handleSendPressed(types.PartialText message) {}

  sendMessage(String msg) {
    if (msg.isNotEmpty) {
      final newMessage = types.TextMessage(
        author: _user,
        createdAt: DateTime
            .now()
            .millisecondsSinceEpoch,
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
  Widget build(BuildContext context) =>
      Scaffold(
        key: ChatManager().scaffoldMessengerKey,
        appBar: const CareyAppBar(
          title: "Carey",
        ),
        body: BlocBuilder<GetMessagesBloc, GetMessagesState>(
          builder: buildChat,
        ),
      );

  Widget buildChat(BuildContext context, GetMessagesState state) {
    if (state is GetMessagesInProgress) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (state is GetMessagesSuccess) {
      _messages = state.messages;

      return Chat(
        messages: state.messages,
        onAttachmentPressed: _handleAttachmentPressed,
        onPreviewDataFetched: _handlePreviewDataFetched,
        onSendPressed: _handleSendPressed,
        showUserAvatars: false,
        showUserNames: true,
        user: _user,
        customBottomWidget: buildBottomBar(),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget buildBottomBar() {
    return Stack(
      children: [
        // CareyInputBarWidget(
        //   onSend: (String msg) {
        //     sendMessage(msg);
        //   },
        //   onAttachmentTap: widget.onAttachmentTap,
        // ),
        BlocListener<CareyUploadRxBloc, CareyUploadRxState>(
          listener: (context, state) {
            if (state is UploadRxSuccess) {
              print("uploading completed !");
              print(state.files.first.link);
              print(state.files);


              final newMessage = types.ImageMessage(
                author: _user,
                createdAt: DateTime
                    .now()
                    .millisecondsSinceEpoch,
                id: AppUtils.generateTrackId(),
                uri:
                'https://www.cnet.com/a/img/resize/624f2b5b354ebdb805d44eeb64f9401ffd4dc475/hub/2024/05/13/1acda696-e74d-4e7e-bfd6-eaf1ccb40ae8/ipad-pro-2024-5.jpg?auto=webp&fit=crop&height=1200&width=1200',
                name: 'new message',
                size: 1000,
              );

              setState(() {
                _messages.insert(0, newMessage);
              });
            }
          }

          ,
          child: CareyInputBarWidget(
            onSend: (String msg) {
              sendMessage(msg);
            },
            onAttachmentTap: widget.onAttachmentTap,
          ),

        ),
      ],
    );
  }
}
