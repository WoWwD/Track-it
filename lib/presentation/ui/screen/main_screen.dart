import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_it/presentation/cubit/portfolio_cubit/portfolio_cubit.dart';
import 'package:track_it/presentation/ui/widget/loader_widget.dart';
import 'package:track_it/presentation/ui/widget/main_list_coins.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
      ),
      appBar: AppBar(title: const Text('Главная')),
      body: Center(
        child: BlocBuilder<PortfolioCubit, PortfolioState>(
          builder: (context, state ) {
            if (state is PortfolioLoaded) return MainListCoins(coins: state.listCoins);
            return const LoaderWidget();
          }
        ),
      )
    );
  }
}
