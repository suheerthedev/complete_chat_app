import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'phone_registration_viewmodel.dart';

class PhoneRegistrationView extends StackedView<PhoneRegistrationViewModel> {
  const PhoneRegistrationView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PhoneRegistrationViewModel viewModel,
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
  PhoneRegistrationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PhoneRegistrationViewModel();
}
