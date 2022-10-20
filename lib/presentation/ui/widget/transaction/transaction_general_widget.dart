import 'package:flutter/cupertino.dart';

class TransactionGeneralWidget extends StatelessWidget {
  final List<Widget> children;

  const TransactionGeneralWidget({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(children: children),
    );
  }
}