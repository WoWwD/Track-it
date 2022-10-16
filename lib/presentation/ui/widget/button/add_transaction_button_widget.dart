import 'package:flutter/material.dart';

class AddTransactionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddTransactionButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Добавить'),
    );
  }
}
