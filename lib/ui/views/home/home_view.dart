import 'package:alwan_chat_app/app/app.locator.dart';
import 'package:alwan_chat_app/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'WhatsUpp',
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
                      chat['chatId'],
                      chat['name']
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            viewModel.addUser();
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
  Widget _chatItem(String name, String message, String time, String chatId, String userName) {
    return GestureDetector(
      onTap: (){
        NavigationService navigationService = locator<NavigationService>();
        navigationService.navigateToChatView(chatId: chatId, userName: userName);
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
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.fetchChats();
  }
}
