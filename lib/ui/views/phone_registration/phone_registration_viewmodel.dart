import 'package:alwan_chat_app/app/app.locator.dart';
import 'package:alwan_chat_app/app/app.router.dart';
import 'package:alwan_chat_app/services/phone_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PhoneRegistrationViewModel extends BaseViewModel {
  final NavigationService navigationService = NavigationService();
  final PhoneAuthService _phoneAuthService = locator<PhoneAuthService>();
  final TextEditingController phoneCont = TextEditingController();
  final DialogService _dialogService = locator<DialogService>();

  Future<void> submitPhoneNumber(String phoneNumber) async {
    setBusy(true);
    try {
      await _phoneAuthService.sendOtp(phoneNumber);
      navigationService.navigateToOtpVerificationView();
    } catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description: e.toString(),
      );
    }
    setBusy(false);
  }

  @override
  void dispose() {
    phoneCont.dispose();
    super.dispose();
  }
}
