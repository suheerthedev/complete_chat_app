import 'package:alwan_chat_app/app/app.locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class SharingViewModel extends BaseViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DialogService _dialogService = locator<DialogService>();

  
  List<Map<String, dynamic>> chats = [];

  void _initialSharing (){
    FlutterSharingIntent.instance.getMediaStream().listen((sharedMedia){
      if(sharedMedia.isNotEmpty && sharedMedia.first.value != null){
        print("Shared Media: $sharedMedia");
      }
    });


    FlutterSharingIntent.instance.getInitialSharing().then((sharedMedia){
      if(sharedMedia.isNotEmpty && sharedMedia.first.value != null){
      print("Shared Media: $sharedMedia");
      }
    });
  }

  void initializeSharingListener() {
    _initialSharing();
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
