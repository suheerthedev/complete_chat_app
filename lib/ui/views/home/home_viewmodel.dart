import 'package:alwan_chat_app/app/app.dialogs.dart';
import 'package:alwan_chat_app/app/app.locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DialogService _dialogService = locator<DialogService>();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  TextEditingController nameCont = TextEditingController();
  TextEditingController userPhoneCont = TextEditingController();

  List<Map<String, dynamic>> chats = [];

  Future<void> addUser() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.userInput,
      title: 'Enter user details',
      description: 'Add user details here',
      data: [
        TextField(
          controller: nameCont,
          decoration: const InputDecoration(hintText: 'Enter Name'),
        ),
        TextField(
          controller: userPhoneCont,
          decoration: const InputDecoration(hintText: 'Enter Phone Number'),
        ),
      ],
      mainButtonTitle: 'Submit',
      secondaryButtonTitle: 'Cancel',
    );
    if (response != null && response.confirmed) {
      try {
        final docRef = users.doc();
        final String chatId = docRef.id;

        final DateTime currentTime = DateTime.now();
        final String formattedTime =
            "${currentTime.hour}:${currentTime.second}";

        await docRef.set({
          'chatId': chatId,
          'name': nameCont.text,
          'phone': userPhoneCont.text,
          'lastMessage': '',
          'lastMessageTime': formattedTime,
        });

        await _dialogService.showDialog(
          title: 'Success!',
          description: 'User successfully added!',
        );

        nameCont.clear();
        userPhoneCont.clear();
      } catch (error) {
        await _dialogService.showDialog(
          title: 'Error',
          description: 'Failed to add user: $error',
        );
      }
    }
  }

  Future<void> fetchChats() async {
    setBusy(true);
    try {
      final QuerySnapshot snapshot = await _firestore.collection('users').get();
      chats = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      rebuildUi();
    } catch (e) {
      _dialogService.showDialog(title: 'Error fetching chats: $e');
      if (e is FirebaseException) {
        _dialogService.showDialog(
            title: 'Error code: ${e.code}',
            description: 'Message: ${e.message}');
      }
    } finally {
      setBusy(false);
    }
  }
}
