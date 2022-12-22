import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_it/data/model/coin/market_coin_model.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import '../../../domain/repository/local_repository/portfolio_local_repository.dart';
import '../../../domain/repository/remote_repository/coin_remote_repository.dart';
import '../../../service/constants/app_constants.dart';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final PortfolioLocalRepository portfolioLocalRepository;
  final CoinRemoteRepository coinRemoteRepository;

  PortfolioCubit({
    required this.portfolioLocalRepository,
    required this.coinRemoteRepository
  }) : super(PortfolioInitial());

  //#region PortfolioList

  Future<void> deletePortfolioByName(String portfolioName) async {
    emit(PortfolioLoading());
    await portfolioLocalRepository.deletePortfolioByName(portfolioName);
    final List<Portfolio>? listPortfolio = await portfolioLocalRepository.getListPortfolio();
    if (listPortfolio != null) {
      if(await portfolioLocalRepository.portfolioStorageIsEmpty()) {
        await portfolioLocalRepository.clearCurrentPortfolioStorage();
        emit(PortfolioList(listPortfolio, ''));
      }
      else {
        await setToCurrentPortfolio(listPortfolio.first.name);
        emit(PortfolioList(listPortfolio, listPortfolio.first.name));
      }
    }
  }

  Future<String?> getCurrentPortfolioName() async => await portfolioLocalRepository.getCurrentPortfolioName();

  Future<void> setToCurrentPortfolio(String portfolioName) async {
    emit(PortfolioLoading());
    await portfolioLocalRepository.setToCurrentPortfolio(portfolioName);
    final List<Portfolio>? listPortfolio = await portfolioLocalRepository.getListPortfolio();
    if (listPortfolio != null) {
      emit(PortfolioList(listPortfolio, portfolioName));
    }
  }

  Future<bool?> portfolioAlreadyExists(String portfolioName) async =>
    await portfolioLocalRepository.portfolioNameAlreadyExists(portfolioName);

  Future<void> getListPortfolio() async {
    emit(PortfolioLoading());
    final List<Portfolio>? listPortfolio = await portfolioLocalRepository.getListPortfolio();
    final String? currentPortfolioName = await getCurrentPortfolioName();
    emit(PortfolioList(listPortfolio ?? [], currentPortfolioName ?? ''));
  }

  //#endregion

  //#region PortfolioCoins

  Future<void> getPortfolio() async {
    emit(PortfolioLoading());
    final Portfolio? currentPortfolioModel = await portfolioLocalRepository.getCurrentPortfolio();
    if(currentPortfolioModel == null) {
      emit(PortfolioNotCreated());
    }
    else {
      final List<String> ids = [];
      final List<MarketCoin> listAssets = [];
      if(currentPortfolioModel.listAssets.isNotEmpty) {
        for(int i = 0; i < currentPortfolioModel.listAssets.length; i++) {
          ids.add(currentPortfolioModel.listAssets[i].idCoin);
        }
        listAssets.addAll(await coinRemoteRepository.getListCoinsByIds(ids));
      }
      emit(PortfolioReceived(currentPortfolioModel, listAssets));
    }
  }

  //#endregion

  Future<void> createPortfolio(String portfolioName) async {
    await portfolioLocalRepository.createPortfolio(portfolioName);
    final String? currentPortfolioName = await getCurrentPortfolioName();
    if (currentPortfolioName == null) {
      await setToCurrentPortfolio(portfolioName);
    }
  }

  Future<String?> portfolioToJson() async {
    final String? currentPortfolioName = await portfolioLocalRepository.getCurrentPortfolioName();
    if (currentPortfolioName != null) {
      final Portfolio? portfolioModel = await portfolioLocalRepository.getPortfolioByName(currentPortfolioName);
      return jsonEncode(portfolioModel!.toJson());
    }
    return null;
  }

  Future<bool> portfolioFromJson(String portfolioJson) async {
    Portfolio? portfolioJsonModel;
    try {
      portfolioJsonModel = Portfolio.fromJson(json.decode(portfolioJson));
      final bool? alreadyExists = await portfolioLocalRepository.portfolioNameAlreadyExists(portfolioJsonModel.name);
      if (alreadyExists != null && alreadyExists) {
        final String portfolioName = DateTime.now().microsecondsSinceEpoch.toString();
        await createPortfolio(portfolioName);
        await portfolioLocalRepository.setPortfolio(
          portfolioName,
          Portfolio(name: portfolioName, listAssets: portfolioJsonModel.listAssets)
        );
        return true;
      }
      await createPortfolio(portfolioJsonModel.name);
      await portfolioLocalRepository.setPortfolio(portfolioJsonModel.name, portfolioJsonModel);
      return true;
    }
    on FormatException {
      return false;
    }
  }
}