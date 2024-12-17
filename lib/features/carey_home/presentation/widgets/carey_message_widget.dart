import 'package:flutter/material.dart';

class ChatMessage {
  final String message;
  final bool isMe;
  final DateTime timestamp;

  ChatMessage({
    required this.message,
    required this.isMe,
    required this.timestamp,
  });
}

class CareyMessageWidget extends StatelessWidget {
  final ChatMessage message;

  const CareyMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isMe ? Colors.deepPurpleAccent : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: message.isMe
                ? const Radius.circular(16)
                : const Radius.circular(0),
            bottomRight: message.isMe
                ? const Radius.circular(0)
                : const Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.message,
              style: TextStyle(
                color: message.isMe ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              _formatTime(message.timestamp),
              style: TextStyle(
                color: message.isMe ? Colors.white70 : Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }
}