import 'dart:io';

import 'package:alwan_chat_app/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UserInfoViewModel extends BaseViewModel {
  final NavigationService navigationService = NavigationService();
  final TextEditingController nameCont = TextEditingController();
  final TextEditingController bioCont = TextEditingController();

  File? _profileImage;

  File? get profileImage => _profileImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery, // Use ImageSource.camera for camera
    );

    if (pickedFile != null) {
      _profileImage = File(pickedFile.path);
      notifyListeners(); // Notify the UI to rebuild
    }
  }

  void submitUserInfo() {
    navigationService.replaceWithHomeView();
  }
}
