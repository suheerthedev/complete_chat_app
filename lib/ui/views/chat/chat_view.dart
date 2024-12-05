import 'package:alwan_chat_app/ui/common/ui_helpers.dart';
import 'package:alwan_chat_app/ui/views/chat/chat_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChatView extends StatelessWidget {
  final String chatId;
  final String userName;

  const ChatView({Key? key, required this.chatId, required this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ChatViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              userName,
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            backgroundColor: Colors.green,
            elevation: 0,
          ),
          body: Center(
            child: Text('Chat with $userName (Chat ID: $chatId)'),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                    width: 300,
                    child: TextField(
                      controller: viewModel.messageCont,
                      decoration: InputDecoration(
                        fillColor: Colors.white10,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                    )),
                    horizontalSpaceSmall,
                FloatingActionButton(
                  
                  onPressed: (){},
                  backgroundColor: Colors.black,
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
