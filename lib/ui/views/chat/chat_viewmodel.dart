import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ChatViewModel extends BaseViewModel {
  final String chatId;
  final List<String>? sharedMedia;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  final TextEditingController messageCont = TextEditingController();
  final ScrollController scrollCont = ScrollController();

  List<Map<String, dynamic>> messages = [];
  bool isLoading = true;

  ChatViewModel({required this.chatId, this.sharedMedia}) {
    if (sharedMedia != null && sharedMedia!.isNotEmpty) {
      sendSharedMedia();
    }
    fetchMessages();
  }

  Future<void> sendSharedMedia() async {
    for (var mediaPath in sharedMedia!) {
      final imageUrl = await uploadImage(mediaPath);
      await sendImageMessage(imageUrl);
    }
  }

  Future<void> fetchMessages() async {
    isLoading = true;
    notifyListeners();

    firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false) 
        .snapshots()
        .listen((snapshot) {
      messages = snapshot.docs
          .map((doc) => {
                'text': doc['text'],
                'imageUrl': doc['imageUrl'],
                'timestamp': doc['timestamp'],
              })
          .toList();
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> sendMessage(String imageUrl) async {
    if (messageCont.text.trim().isEmpty) return;

     final message = {
      'text': '',
      'imageUrl': imageUrl,
      'senderId': chatId,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message);

    messageCont.clear();

    scrollCont.animateTo(
      scrollCont.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final imageUrl = await uploadImage(image.path);
      await sendImageMessage(imageUrl);
    }
  }

  Future<String> uploadImage(String mediaPath) async {
    final ref = storage.ref().child('chatImages/${DateTime.now().millisecondsSinceEpoch}');
    final file = File(mediaPath);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<void> sendImageMessage(String imageUrl) async {
    final message = {
      'text': '',
      'imageUrl': imageUrl,
      'senderId': "yourUserId", // Replace with your user ID
      'timestamp': FieldValue.serverTimestamp(),
    };

    await firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message);

    // Automatically scroll to the bottom of the list
    scrollCont.animateTo(
      scrollCont.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
