import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_it/presentation/cubit/portfolio_cubit/portfolio_cubit.dart';
import 'package:track_it/presentation/ui/widget/button/portfolio_floating_button.dart';
import 'package:track_it/service/di/di.dart' as di;
import '../../../service/constant/app_constants.dart';
import '../widget/first_launch_widget.dart';
import '../widget/loader_widget.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const PortfolioFloatingButton(),
      appBar: AppBar(title: const Text('Портфолио')),
      body: BlocProvider(
        create: (_) => di.getIt<PortfolioCubit>()..firstLaunch(AppConstants.MAIN_PORTFOLIO),
        child: Center(
          child: BlocBuilder<PortfolioCubit, PortfolioState>(
            builder: (context, state) {
              if(state is PortfolioReceived) {
                return ListView.builder(
                  itemCount: state.portfolio.listAssets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: ListTile(
                        leading: Text(state.portfolio.listAssets[index].idCoin),
                        title: Text(state.portfolio.name),
                      )
                    );
                  },
                );
              }
              if(state is PortfolioLoading) return const Loader();
              if(state is PortfolioFirstLaunch) return const Center(child: FirstLaunchWidget());
              return const SizedBox();
            },
          )
        ),
      )
    );
  }
}