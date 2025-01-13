import 'package:carey/features/carey_home/presentation/bloc/index.dart';
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

    // ["hc_name": "kiran", "name": "psp google", "type": "ios", "user_object_id": "U79433"]
// URL1 : https://chat.wellthy.me/user/register
// headers1 : ["x-api-checksum": "aHR0cHM6Ly9jaGF0LndlbGx0aHkubWUvdXNlci9yZWdpc3Rlcg==",
// "x-id-token": "U2FsdGVkX19m/K9BWtm+03BXUS9QHkrlFkUEjbmgljQ=",
// "x-access-token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbmNyeXB0ZWQiOiJVMkZzZEdWa1gxL0M3eFdxeFF3UERMNHROazZzdGZjQXlLN1NDMU5vcldYVmd1QzhFRExlWk9NdUNyS3BCSDJER2xJMkRoWitzNHZuVGRLOXpLbldZVVdzZzRMWjFVQTFrYjBBT09JSW9lQT0iLCJpYXQiOjE3MzY0ODkzMTQsImV4cCI6MTczNzc4NTMxNH0.mRiA6lqVuI0KT3VjAWmzV0_6R6f0_CrmiisWNY6QFC4"]
    context.read<ChatConnectBloc>().add(
        CreateUserEvent(userId: 'U79433', hcName: "kiran", name: "psp google"));
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
            message:
                "Thanks for your message! Thanks for your message! Thanks for your message!",
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
