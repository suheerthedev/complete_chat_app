import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  final String chatId;
  final String userName;

  const ChatView({Key? key, required this.chatId, required this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('Chat with $userName (Chat ID: $chatId)'),
      ),
    );
  }
}
