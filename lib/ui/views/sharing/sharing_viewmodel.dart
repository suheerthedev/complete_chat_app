import 'package:alwan_chat_app/app/app.locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SharingViewModel extends BaseViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DialogService _dialogService = locator<DialogService>();

  List<String> _sharedMediaPaths = [];
  List<String> get sharedMediaPaths => _sharedMediaPaths;

  List<Map<String, dynamic>> chats = [];

  void _initialSharing() {
    FlutterSharingIntent.instance.getMediaStream().listen((sharedMedia) {
      if (sharedMedia.isNotEmpty) {
        sharedMedia.forEach((media) {
          final path = media.value;
          if (path != null) {
            switch (media.type) {
              case SharedMediaType.IMAGE:
                print("Image received: $path");
                break;
              case SharedMediaType.VIDEO:
                print("Video received: $path");
                break;
              case SharedMediaType.FILE:
                print("File received: $path");
                break;
              case SharedMediaType.TEXT:
                print("Text received: $path");
                break;
              case SharedMediaType.URL:
                print("URL received: $path");
                break;
              default:
                print("Other media received: $path");
            }
          } else {
            print("Media value is null");
          }
        });
        // Map and filter non-null paths
        _sharedMediaPaths = sharedMedia
            .map((e) => e.value) // Access the nullable `value`
            .where((path) => path != null) // Filter out null values
            .cast<String>() // Cast to non-nullable String
            .toList();
      }
    });

    FlutterSharingIntent.instance.getInitialSharing().then((sharedMedia) {
      if (sharedMedia.isNotEmpty) {
        _sharedMediaPaths = sharedMedia
            .map((e) => e.value)
            .where((path) => path != null)
            .cast<String>()
            .toList();
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
