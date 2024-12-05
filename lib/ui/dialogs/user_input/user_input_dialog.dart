import 'package:flutter/material.dart';
import 'package:alwan_chat_app/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'user_input_dialog_model.dart';

class UserInputDialog extends StackedView<UserInputDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const UserInputDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UserInputDialogModel viewModel,
    Widget? child,
  ) {
    final List<Widget> inputFields = request.data as List<Widget>? ?? [];
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title and Description Section
            if (request.title != null)
              Text(
                request.title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            verticalSpaceSmall,
            if (request.description != null)
              Text(
                request.description!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            verticalSpaceSmall,

            // Input Fields Section
            Column(
              children: inputFields.map((field) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: field,
                );
              }).toList(),
            ),

            verticalSpaceSmall,

            // Action Buttons Section
            Row(
              children: [
                if (request.secondaryButtonTitle != null)
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () =>
                          completer(DialogResponse(confirmed: false)),
                      child: Text(
                        request.secondaryButtonTitle!,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                if (request.secondaryButtonTitle != null)
                  const SizedBox(width: 10),
                if (request.mainButtonTitle != null)
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => completer(DialogResponse(
                        confirmed: true,
                        data: inputFields
                            .whereType<TextField>()
                            .map((field) => (field.controller)?.text)
                            .toList(),
                      )),
                      child: Text(
                        request.mainButtonTitle!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  UserInputDialogModel viewModelBuilder(BuildContext context) =>
      UserInputDialogModel();
}
