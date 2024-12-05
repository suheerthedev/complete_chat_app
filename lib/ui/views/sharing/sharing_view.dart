import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'sharing_viewmodel.dart';

class SharingView extends StackedView<SharingViewModel> {
  const SharingView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SharingViewModel viewModel,
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
  SharingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SharingViewModel();
}
