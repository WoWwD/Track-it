import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_it/presentation/cubit/portfolio_cubit/portfolio_cubit.dart';
import 'package:track_it/presentation/ui/widget/button/add_transaction_button.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const AddTransactionButton(),
      appBar: AppBar(title: const Text('Главная')),
      body: Center(
        child: BlocBuilder<PortfolioCubit, PortfolioState>(
          builder: (context, state) {
            return const Text('Главная');
          },
        )
      )
    );
  }
}