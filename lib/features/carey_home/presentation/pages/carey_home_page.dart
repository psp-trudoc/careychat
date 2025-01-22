import 'package:carey/core/network/mqtt_service.dart';
import 'package:carey/core/utils/app_utils.dart';
import 'package:carey/core/widgets/app_bar.dart';
import 'package:carey/features/carey_home/domain/entities/chat_message.dart';
import 'package:carey/features/carey_home/presentation/bloc/index.dart';
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

  final _user = const types.User(
    id: 'U79433',
  );

  @override
  void initState() {
    super.initState();
    context.read<ChatConnectBloc>().add(GetMetaDataEvent());

    MQTTService().connectChat();
  }

  loadHistory() {
    print("loadHistory");
  }

  void _sendMessage() {
    // if (_messageController.text.trim().isNotEmpty) {

    final newMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: AppUtils.generateTrackId(),
      text: _messageController.text.trim(),
    );

    setState(() {
      _messages.insert(0, newMessage);
    });

    // context.read<SendMessageBloc>().add(
    //       SendMessage(
    //         msg: newMessage,
    //       ),
    //     );

    _messageController.clear();

    // Simulate receiving a reply
    // Future.delayed(const Duration(seconds: 1), () {
    //   setState(() {
    //     _messages.add(ChatMessage(
    //       message:
    //           "Thanks for your message! Thanks for your message! Thanks for your message!",
    //       isMe: false,
    //       timestamp: DateTime.now(),
    //     ));
    //   });
    // });
    // }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const CareyAppBar(
          title: "Carey",
        ),
        body: Chat(
          messages: _messages,
          onAttachmentPressed: _handleAttachmentPressed,
          onMessageTap: _handleMessageTap,
          onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          showUserAvatars: true,
          showUserNames: true,
          user: _user,
        ),
      );

  _handleAttachmentPressed() {
    final newMessage = types.TextMessage(
      author: _user,
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

    final _hc = const types.User(
      id: 'U79444',
    );

    final newMessage = types.TextMessage(
      author: _hc,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: AppUtils.generateTrackId(),
      text: message.text.trim(),
    );

    setState(() {
      _messages.insert(0, newMessage);
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("Chat"),
  //       backgroundColor: Colors.deepPurpleAccent,
  //     ),
  //     body: Column(
  //       children: [
  //         Expanded(
  //           child: ListView.builder(
  //             reverse: true,
  //             itemCount: _messages.length,
  //             itemBuilder: (context, index) {
  //               final message = _messages.reversed.toList()[index];
  //               return CareyMessageWidget(message: message);
  //             },
  //           ),
  //         ),
  //         _buildMessageInput(),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.grey[300],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: "Type a message...",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.deepPurpleAccent),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
