import 'package:flutter/material.dart';

class PrimaryDialog extends StatelessWidget {
  final String title;
  final String? contentText;
  final String textConfirmButton;
  final String textCancelButton;
  final VoidCallback onPressedConfirm;
  final VoidCallback? onPressedCancel;

  const PrimaryDialog({
    Key? key,
    required this.title,
    this.contentText,
    this.textConfirmButton = 'Да',
    this.textCancelButton = 'Нет',
    required this.onPressedConfirm,
    this.onPressedCancel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: contentText == null? null: Text(contentText!),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onPressedConfirm,
              child: Text(textConfirmButton)
            ),
            const SizedBox(width: 24),
            ElevatedButton(
              onPressed: onPressedCancel ?? () => Navigator.pop(context),
              child: Text(textCancelButton)
            )
          ],
        ),
      ],
    );
  }
}
