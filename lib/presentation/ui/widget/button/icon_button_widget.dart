import 'package:flutter/material.dart';

class IconButtonV2 extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;

  const IconButtonV2({
    Key? key,
    required this.onPressed,
    required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
    );
  }
}
