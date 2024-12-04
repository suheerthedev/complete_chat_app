import 'package:alwan_chat_app/app/app.locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DialogService  _dialogService = locator<DialogService>();

  List<Map<String, dynamic>> chats = [];

  Future<void> fetchChats() async {
    setBusy(true); 
    try {
      final QuerySnapshot snapshot = await _firestore.collection('dummyChats').get();
      chats = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      rebuildUi(); 
    } catch (e) {
      _dialogService.showDialog(title: 'Error fetching chats: $e');
      if (e is FirebaseException) {
        _dialogService.showDialog(title:  'Error code: ${e.code}' , description: 'Message: ${e.message}');
      }
    } finally {
      setBusy(false); 
    }
  }
}
