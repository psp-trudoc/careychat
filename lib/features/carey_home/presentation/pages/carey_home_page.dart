import 'package:carey/core/network/mqtt_service.dart';
import 'package:carey/core/utils/app_utils.dart';
import 'package:carey/features/carey_home/domain/entities/chat_message.dart';
import 'package:carey/features/carey_home/presentation/bloc/index.dart';
import 'package:carey/features/carey_home/presentation/bloc/send_message_bloc/index.dart';
import 'package:carey/features/carey_home/presentation/widgets/carey_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CareyHomePage extends StatefulWidget {
  const CareyHomePage({super.key});

  @override
  CareyHomePageState createState() => CareyHomePageState();
}

class CareyHomePageState extends State<CareyHomePage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    context.read<ChatConnectBloc>().add(GetMetaDataEvent());

    MQTTService().connectChat();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      ChatMessage newMessage = ChatMessage(
        trackId: AppUtils.generateTrackId(),
        id: 123,
        type: "",
        sender: "U79433",
        mimeType: "",
        body: _messageController.text.trim(),
        isSent: true,
      );

      setState(() {
        _messages.add(newMessage);
      });

      context.read<SendMessageBloc>().add(
            SendMessage(
              msg: newMessage,
            ),
          );

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages.reversed.toList()[index];
                return CareyMessageWidget(message: message);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

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
