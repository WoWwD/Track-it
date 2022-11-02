import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_it/data/model/coin/market_coin_model.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import '../../../data/model/asset_model.dart';
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
    final List<Portfolio> listPortfolio = await portfolioLocalRepository.getListPortfolio();
    if(await portfolioLocalRepository.portfolioStorageIsEmpty()) {
      await portfolioLocalRepository.clearCurrentPortfolioStorage();
      emit(PortfolioList(listPortfolio, ''));
    }
    else {
      await setToCurrentPortfolio(listPortfolio.first.name);
      emit(PortfolioList(listPortfolio, listPortfolio.first.name));
    }
  }

  Future<String?> getCurrentPortfolioName() async => await portfolioLocalRepository.getCurrentPortfolioName();

  Future<void> setToCurrentPortfolio(String portfolioName) async {
    emit(PortfolioLoading());
    await portfolioLocalRepository.setToCurrentPortfolio(portfolioName);
    emit(PortfolioList(await portfolioLocalRepository.getListPortfolio(), portfolioName));
  }

  Future<bool> portfolioAlreadyExists(String portfolioName) async
    => await portfolioLocalRepository.portfolioNameAlreadyExists(portfolioName);

  Future<void> getListPortfolio() async {
    emit(PortfolioLoading());
    final List<Portfolio> listPortfolio = await portfolioLocalRepository.getListPortfolio();
    final String? currentPortfolioName = await getCurrentPortfolioName();
    emit(PortfolioList(listPortfolio, currentPortfolioName ?? ''));
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

  Future<void> getTransactions(String portfolioName, String idCoin) async {
    emit(PortfolioLoading());
    final Portfolio? portfolio = await portfolioLocalRepository.getPortfolioByName(portfolioName);
    final Asset assetModel = portfolio!.listAssets.firstWhere((element) => element.idCoin == idCoin);
    emit(PortfolioTransactions(assetModel.listTransactions));
  }

  Future<void> deleteAssetById(String portfolioName, String idCoin) async {
    final Portfolio? portfolioModel = await portfolioLocalRepository.getPortfolioByName(portfolioName);
    if(portfolioModel != null) {
      final Asset assetModel = portfolioModel.listAssets.firstWhere((element) => element.idCoin == idCoin);
      portfolioModel.listAssets.remove(assetModel);
      await portfolioLocalRepository.setPortfolio(portfolioName, portfolioModel);
    }
  }

  Future<void> deleteTransactionByIndex(int listTransactionsLength, String portfolioName, int indexTransaction, String idCoin) async {
    if(listTransactionsLength == 1) {
      await deleteAssetById(portfolioName, idCoin);
    }
    else{
      final Portfolio? portfolioModel = await portfolioLocalRepository.getPortfolioByName(portfolioName);
      if(portfolioModel != null) {
        final int indexAsset = portfolioModel.listAssets.indexWhere((element) => element.idCoin == idCoin);
        portfolioModel.listAssets[indexAsset].listTransactions.removeAt(indexTransaction);
        await portfolioLocalRepository.setPortfolio(portfolioName, portfolioModel);
      }
      getTransactions(portfolioName, idCoin);
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