import 'package:alwan_chat_app/app/app.locator.dart';
import 'package:alwan_chat_app/app/app.router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class PhoneAuthService {
  final NavigationService navigationService = NavigationService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DialogService _dialogService = locator<DialogService>();

  String? _verificationId; // Store the verificationId for later use

  String? get verificationId => _verificationId;

  Future<void> sendOtp(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        //auto verify
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          _dialogService.showDialog(
              title: 'Success',
              description: 'Phone number verified automatically.');
          navigationService.replaceWithHomeView();
        },

        //failed verification
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            _dialogService.showDialog(
                title: 'Invalid Phone Number', description: e.toString());
          } else if (e.code == 'missing-phone-number') {
            _dialogService.showDialog(
                title: 'Missing Phone Number', description: e.toString());
          }
        },

        //getting otp code
        codeSent: (String verificationId, int? resendToken) async {
          _verificationId = verificationId;
          //for debugging purpose
          print('Verification code sent to $phoneNumber');
        },

        //Timeout
        codeAutoRetrievalTimeout: (String verificationId) {
          // _verificationId = null;

          // _dialogService.showDialog(title: 'Timed out',  description: 'OTP retrieval timed out. Please request a new OTP.');
        });
  }

  Future<void> verifyOtp(String smsCode) async {
    if (_verificationId == null) {
      _dialogService.showDialog(
          title: 'Verification id is missing please try again.');
      return;
    }
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: smsCode);

    await _auth.signInWithCredential(credential);
  }
}
