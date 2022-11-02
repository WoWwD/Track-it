import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:track_it/presentation/ui/widget/bottom_sheet_content/create_portfolio_widget.dart';
import 'package:track_it/presentation/ui/widget/custom_list_view_widget.dart';
import '../../../../service/constant/app_styles.dart';
import '../../../cubit/portfolio_cubit/portfolio_cubit.dart';
import 'package:track_it/service/di.dart' as di;
import '../card/card_portfolio_widget.dart';
import '../primary_modal_bottom_sheet.dart';
import '../skeletons/list_view_skeleton_widget.dart';

class ListPortfolioWidget extends StatelessWidget {
  final Function refreshPortfolioScreen;

  const ListPortfolioWidget({Key? key, required this.refreshPortfolioScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
                  await context.read<PortfolioCubit>().deletePortfolioByName(state.listPortfolio[index].name);
                  refreshPortfolioScreen();
                },
                onChanged: () {
                  context.read<PortfolioCubit>().setToCurrentPortfolio(state.listPortfolio[index].name);
                  refreshPortfolioScreen();
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
              content: CreatePortfolio(refreshState: () => context.read<PortfolioCubit>().getListPortfolio()),
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