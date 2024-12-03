import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'user_info_viewmodel.dart';

class UserInfoView extends StackedView<UserInfoViewModel> {
  const UserInfoView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UserInfoViewModel viewModel,
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
  UserInfoViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UserInfoViewModel();
}
