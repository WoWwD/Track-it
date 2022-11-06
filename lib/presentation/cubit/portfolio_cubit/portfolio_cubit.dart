import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_it/data/model/coin/market_coin_model.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import '../../../domain/repository/local_repository/portfolio_local_repository.dart';
import '../../../domain/repository/remote_repository/coin_remote_repository.dart';

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
    if (listPortfolio != null && currentPortfolioName != null) {
      emit(PortfolioList(listPortfolio, currentPortfolioName));
    }
  }

  //#endregion

  //#region PortfolioCoins

  Future<void> getCoins() async {
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
      emit(PortfolioCoins(currentPortfolioModel.name, listAssets));
    }
  }

  //#endregion

  Future<void> createPortfolio(String portfolioName) async {
    await portfolioLocalRepository.createPortfolio(portfolioName);
    final String? currentPortfolioName = await getCurrentPortfolioName();
    if(currentPortfolioName == null) {
      await setToCurrentPortfolio(portfolioName);
    }
  }

  Future<String> portfolioToJson(String portfolioName) async {
    final Portfolio? portfolioModel = await portfolioLocalRepository.getPortfolioByName(portfolioName);
    return jsonEncode(portfolioModel!.toJson());
  }

  Future<void> portfolioFromJson(String jsonPortfolio, String portfolioName) async {
    final Portfolio portfolioModel = Portfolio.fromJson(json.decode(jsonPortfolio));
    await portfolioLocalRepository.setPortfolio(portfolioName, portfolioModel);
  }
}