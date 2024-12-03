import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'otp_verification_viewmodel.dart';

class OtpVerificationView extends StackedView<OtpVerificationViewModel> {
  const OtpVerificationView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OtpVerificationViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  OtpVerificationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OtpVerificationViewModel();
}
