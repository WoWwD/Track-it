import 'package:flutter/cupertino.dart';

class TransactionGeneralWidget extends StatelessWidget {
  final Widget textFieldAmount;
  final Widget? textFieldPrice;
  final Widget textFieldDatePicker;
  final Widget textFieldNote;

  const TransactionGeneralWidget({
    Key? key,
    required this.textFieldAmount,
    this.textFieldPrice,
    required this.textFieldDatePicker,
    required this.textFieldNote
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          const SizedBox(height: 24),
          textFieldAmount,
          textFieldPrice == null? const SizedBox(height: 0): Column(
            children: [
              const SizedBox(height: 24),
              textFieldPrice!,
            ],
          ),
          const SizedBox(height: 24),
          textFieldDatePicker,
          const SizedBox(height: 24),
          textFieldNote
        ]
      ),
    );
  }
}