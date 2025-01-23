import 'package:carey/core/constants/config.dart';
import 'package:carey/core/network/mqtt_service.dart';
import 'package:carey/core/theme/app_colors.dart';
import 'package:carey/core/utils/app_utils.dart';
import 'package:carey/core/widgets/app_bar.dart';
import 'package:carey/core/widgets/buttons/td_progress_button.dart';
import 'package:carey/core/widgets/gap.dart';
import 'package:carey/features/carey_home/presentation/bloc/get_messages_bloc/index.dart';
import 'package:carey/features/carey_home/presentation/bloc/send_message_bloc/index.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class CareyHomePage extends StatefulWidget {
  const CareyHomePage({super.key});

  @override
  CareyHomePageState createState() => CareyHomePageState();
}

class CareyHomePageState extends State<CareyHomePage> {
  final TextEditingController _messageController = TextEditingController();

  // final List<ChatMessage> _messages = [];
  List<types.Message> _messages = [];
  bool isMessageSending = false;

  final _user = const types.User(
    id: 'U78853',
  );

  @override
  void initState() {
    super.initState();
    //  context.read<ChatConnectBloc>().add(GetMetaDataEvent());

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
      createdAt: DateTime.now().millisecondsSinceEpoch,
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

  _handlePreviewDataFetched(
      types.TextMessage message, types.PreviewData previewData) {
    print("_handlePreviewDataFetched");
  }

  _handleSendPressed(types.PartialText message) {
    print("_handleSendPressed");

    // final newMessage = types.TextMessage(
    //   author: _user,
    //   createdAt: DateTime.now().millisecondsSinceEpoch,
    //   id: AppUtils.generateTrackId(),
    //   text: message.text.trim(),
    // );
    //
    // setState(() {
    //   _messages.insert(0, newMessage);
    // });
    //
    // context.read<SendMessageBloc>().add(
    //       SendTextMessage(
    //         msg: message.text.trim(),
    //       ),
    //     );
  }

  Future<void> _sendMessage() async {
    print("_handleSendPressed");

    if (_messageController.text.trim().isNotEmpty) {
      final newMessage = types.TextMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: AppUtils.generateTrackId(),
        text: _messageController.text.trim(),
      );

      setState(() {
        _messages.insert(0, newMessage);
      });

      context.read<SendMessageBloc>().add(
            SendTextMessage(
              msg: _messageController.text.trim(),
            ),
          );

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: const CareyAppBar(
        title: "Carey",
      ),
      body: BlocBuilder<GetMessagesBloc, GetMessagesState>(
        builder: buildChat,
      ));

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
        customBottomWidget: _buildMessageInput(),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor().grey120,
              ),
              padding: const EdgeInsets.only(left: defaultPadding),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Gap(
            width: 30,
          ),
          BlocListener<SendMessageBloc, SendMessageState>(
              listener: (context, state) {
                setState(() {

                  print("STATE: $state");

                  if (state is SendMessageInProgress) {
                    isMessageSending = true;
                  } else {
                    isMessageSending = false;
                  }
                });
              },
              child: TdProgressButton(
                onPressed: _sendMessage,
                isLoading: isMessageSending,
              )),
        ],
      ),
    );
  }
}
