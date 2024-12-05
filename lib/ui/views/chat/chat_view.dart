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
    return ViewModelBuilder<ChatViewModel>.reactive(
      viewModelBuilder: () => ChatViewModel(chatId: chatId),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              userName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.green,
            elevation: 0,
          ),
          body: Column(
            children: [
              Expanded(
                child: viewModel.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        controller: viewModel.scrollCont,
                        itemCount: viewModel.messages.length,
                        reverse: false,
                        itemBuilder: (context, index) { 
                          final message = viewModel.messages[index];
                          return Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: message['imageUrl'] != ''
                                  ? Image.network(message['imageUrl'])
                                  : Text(
                                      message['text'],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 80),
              
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                    width: 270,
                    child: TextField(
                      controller: viewModel.messageCont,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        suffixIcon: IconButton(
                            onPressed: () => viewModel.pickImage(),
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                              size: 27,
                            )),
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
                  onPressed: () => viewModel.sendMessage(),
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
