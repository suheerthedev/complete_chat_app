import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
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
        automaticallyImplyLeading: false,
        title: const Text(
          'WhatsUpp',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => viewModel.fetchChats(), // Refresh chats
          ),
        ],
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator()) // Show loader
          : viewModel.chats.isEmpty
              ? const Center(child: Text('No chats available.'))
              : ListView.builder(
                  itemCount: viewModel.chats.length,
                  itemBuilder: (context, index) {
                    final chat = viewModel.chats[index];
                    return _chatItem(
                      chat['sender'] ?? 'Unknown',
                      chat['message'] ?? '',
                      chat['time'] ?? '',
                    );
                  },
                ),
    );
  }

  Widget _chatItem(String name, String message, String time) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(FontAwesomeIcons.user)),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time,
              style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.fetchChats(); // Fetch chats when view is ready
  }
}
