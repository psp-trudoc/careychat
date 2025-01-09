import 'package:carey/features/carey_home/presentation/widgets/carey_message_widget.dart';
import 'package:flutter/material.dart';

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
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          message: _messageController.text.trim(),
          isMe: true,
          timestamp: DateTime.now(),
        ));
      });
      _messageController.clear();
      // Simulate receiving a reply
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _messages.add(ChatMessage(
            message: "Thanks for your message! Thanks for your message! Thanks for your message!",
            isMe: false,
            timestamp: DateTime.now(),
          ));
        });
      });
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


