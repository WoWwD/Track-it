import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import '../../../data/model/asset_model.dart';
import '../../../data/repository/local_repository/portfolio_local_repository.dart';
import '../../../service/constant/app_constants.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final PortfolioLocalRepository portfolioLocalRepository;

  StatisticsCubit({
    required this.portfolioLocalRepository
  }) : super(StatisticsInitial());

  Future<void> emitToStatisticsSingleCoinState(String portfolioName, String idCoin) async {
    emit(StatisticsLoading());
    final Portfolio portfolio = await portfolioLocalRepository.getPortfolio(portfolioName);
    final Asset assetModel = portfolio.listAssets.firstWhere((element) => element.idCoin == idCoin);
    emit(StatisticsSingleCoin(assetModel.listTransactions));
  }
}
