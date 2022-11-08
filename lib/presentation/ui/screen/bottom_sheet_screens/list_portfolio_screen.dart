import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:track_it/presentation/ui/widget/custom_list_view_widget.dart';
import '../../../../service/constant/app_styles.dart';
import '../../../cubit/portfolio_cubit/portfolio_cubit.dart';
import 'package:track_it/service/di.dart' as di;
import '../../widget/card/card_portfolio_widget.dart';
import '../../widget/primary_modal_bottom_sheet.dart';
import '../../widget/skeletons/list_view_skeleton_widget.dart';
import 'create_portfolio_screen.dart';

class ListPortfolioScreen extends StatelessWidget {
  final Function refreshMainScreen;

  const ListPortfolioScreen({Key? key, required this.refreshMainScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PortfolioCubit>(
      create: (_) => di.getIt<PortfolioCubit>()..getListPortfolio(),
      child: BlocBuilder<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
          return Skeleton(
            isLoading: state is PortfolioLoading,
            skeleton: const ListViewSkeleton(height: 48),
            child: state is PortfolioList? _content(state, context) : const SizedBox()
          );
        },
      ),
    );
  }

  Widget _content(PortfolioList state, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomListView(
            itemCount: state.listPortfolio.length,
            itemBuilder: (context, index) {
              return CardPortfolio(
                portfolioName: state.listPortfolio[index].name,
                amountAssets: state.listPortfolio[index].listAssets.length,
                isCurrent: state.currentPortfolioName == state.listPortfolio[index].name,
                deletePortfolio: () async {
                  context.read<PortfolioCubit>().deletePortfolioByName(state.listPortfolio[index].name);
                  refreshMainScreen();
                },
                onChanged: () {
                  context.read<PortfolioCubit>().setToCurrentPortfolio(state.listPortfolio[index].name);
                  refreshMainScreen();
                }
              );
            }
          ),
        ),
        Padding(
          padding: AppStyles.mainPadding,
          child: ListTile(
            onTap: () async => await showPrimaryModalBottomSheet(
              context: context,
              content: CreatePortfolioScreen(
                refreshState: () {
                  context.read<PortfolioCubit>().getListPortfolio();
                  refreshMainScreen();
                }
              ),
              maxHeight: 150,
              title: 'Создание портфеля'
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)),
            leading: const Icon(Icons.add),
            title: const Text('Добавить портфель'),
          ),
        )
      ],
    );
  }
}