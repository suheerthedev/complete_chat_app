import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:stacked/stacked.dart';
import 'otp_verification_viewmodel.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpVerificationViewModel>.reactive(
      viewModelBuilder: () => OtpVerificationViewModel(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'ENTER YOUR OTP',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                textAlign: TextAlign.center,
              ),
              OtpTextField(
                borderRadius: BorderRadius.circular(10),
                margin: const EdgeInsets.all(6),
                fieldWidth: 40,
                fieldHeight: 55,
                numberOfFields: 6,
                focusedBorderColor: Colors.green,
                showFieldAsBox: true,
                onSubmit: (String verificationCode) {
                  model.onOtpComplete(verificationCode);
                },
              ),
              Column(
                children: [
                  const Text(
                    "Didn't receive OTP?",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                  InkWell(
                    onTap: () {
                      model.resendOtp(model.otpCont.toString());
                    },
                    child: const Text(
                      "Resend code",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: model.submitOtp,
                  child: model.isBusy
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Verify',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(
                height: 300,
              )
            ],
          ),
        ),
      ),
    );
  }
}
