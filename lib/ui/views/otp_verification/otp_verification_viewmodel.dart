import 'package:alwan_chat_app/app/app.locator.dart';
import 'package:alwan_chat_app/app/app.router.dart';
import 'package:alwan_chat_app/services/phone_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OtpVerificationViewModel extends BaseViewModel {
  final NavigationService navigationService = NavigationService();
  final PhoneAuthService _phoneAuthService = locator<PhoneAuthService>();
  final DialogService _dialogService = locator<DialogService>();

  final TextEditingController otpCont = TextEditingController();

  Future<void> submitOtp() async {
    String otp = otpCont.text.trim();

    if (otp.isEmpty || otp.length != 6) {
      _dialogService.showDialog(
          title: 'Invalid Otp',
          description: 'Please enter a valid 6 digit code');
      return;
    }

    setBusy(true);
    try {
      await _phoneAuthService.verifyOtp(otp);
      _dialogService.showDialog(
          title: 'Success', description: 'Phone number verified successfully.');
      navigationService.replaceWithUserInfoView();
    } catch (e) {
      _dialogService.showDialog(
          title: 'Verfication Failed', description: e.toString());
    }
    setBusy(false);
  }

  Future<void> resendOtp(String phoneNumber) async {
    setBusy(true);
    try {
      await _phoneAuthService.sendOtp(phoneNumber);
      _dialogService.showDialog(
        title: 'OTP Resent',
        description: 'A new OTP has been sent to your phone.',
      );
    } catch (e) {
      _dialogService.showDialog(title: 'Error', description: e.toString());
    }
    setBusy(false);
  }

  void onOtpComplete(String otp) {
    otpCont.text = otp; // Assign the completed OTP to the controller
  }

  @override
  void dispose() {
    otpCont.dispose();
    super.dispose();
  }
}
