import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_it/presentation/ui/widget/text_field_transaction_widget.dart';
import '../../../cubit/transaction_cubit/transaction_cubit.dart';

class BuyTransaction extends StatelessWidget {
  const BuyTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        return Column(
          children: const [
            Text('Найти монету ->'),
            SizedBox(height: 24),
            TextFieldTransaction(labelText: 'Количество'),
            SizedBox(height: 24),
            TextFieldTransaction(labelText: 'Цена'),
            SizedBox(height: 24),
            TextFieldTransaction(labelText: 'Дата'),
            SizedBox(height: 24),
            Text('Примечание'),
          ],
        );
      },
    );
  }
}
