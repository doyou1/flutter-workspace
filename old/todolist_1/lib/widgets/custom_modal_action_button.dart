import 'package:flutter/material.dart';

import 'custom_button.dart';

class CustomModalActionButton extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onSave;

  CustomModalActionButton({required this.onClose, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomButton(
          onPressed: onClose,
          buttonText: "Close",
          color: Colors.white,
          textColor: Theme.of(context).colorScheme.secondary,
        ),
        CustomButton(
            onPressed: onSave,
            buttonText: "Save",
            color: Theme.of(context).colorScheme.secondary,
            textColor: Colors.white),
      ],
    );
  }
}
