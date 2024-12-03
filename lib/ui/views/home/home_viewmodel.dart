import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> chats = [];

  // Fetch chat data from Firestore
  Future<void> fetchChats() async {
    setBusy(true); // Show a loading state
    try {
      print('Fetching chats...');
      final QuerySnapshot snapshot = await _firestore.collection('dummyChats').get();
      print('Documents fetched: ${snapshot.docs.length}');
      chats = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      print('Chats: $chats');
      rebuildUi(); // Notify the UI to rebuild
    } catch (e) {
      print('Error fetching chats: $e');
      if (e is FirebaseException) {
        print('Error code: ${e.code}, Message: ${e.message}');
      }
    } finally {
      setBusy(false); // Stop loading state
    }
  }
}
