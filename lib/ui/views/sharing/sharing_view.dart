import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

import 'sharing_viewmodel.dart';

class SharingView extends StackedView<SharingViewModel> {
  const SharingView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SharingViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Recent',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            onPressed: () => viewModel.fetchChats(),
          ),
        ],
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : viewModel.chats.isEmpty
              ? const Center(child: Text('No chats available.'))
              : ListView.builder(
                  itemCount: viewModel.chats.length,
                  itemBuilder: (context, index) {
                    final chat = viewModel.chats[index];
                    return _chatItem(
                      chat['name'] ?? 'Unknown',
                      chat['phone'] ?? '',
                      chat['lastMessageTime'] ?? '',
                    );
                  },
                ),
      
    );
  }

  Widget _chatItem(String name, String message, String time) {
    return GestureDetector(
      onTap: () {
        //Navigate to chat screen
      },
      child: ListTile(
        leading: const CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(
              FontAwesomeIcons.user,
              color: Colors.white,
            )),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(time,
                style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
  

  @override
  SharingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SharingViewModel();
}