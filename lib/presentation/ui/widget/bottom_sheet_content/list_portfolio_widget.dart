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
  const ListPortfolioWidget({Key? key}) : super(key: key);

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
                isCurrent: index == 2,
                deletePortfolio: () => context.read<PortfolioCubit>()
                  .deletePortfolioByName(state.listPortfolio[index].name),
                onChanged: (bool? value) {  },
              );
            }
          ),
        ),
        _createPortfolio(context)
      ],
    );
  }

  Widget _createPortfolio(BuildContext context) {
    return Padding(
      padding: AppStyles.mainPadding,
      child: ListTile(
        onTap: () async => await showPrimaryModalBottomSheet(context, CreatePortfolio(contextCubit: context), 150),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)),
        leading: const Icon(Icons.add),
        title: const Text('Добавить портфель'),
      ),
    );
  }
}