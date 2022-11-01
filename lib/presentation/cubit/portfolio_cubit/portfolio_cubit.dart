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

  Future<void> createPortfolio(String portfolioName) async {
    emit(PortfolioLoading());
    await portfolioLocalRepository.createPortfolio(portfolioName);
    final String? currentPortfolioName = await getCurrentPortfolioName();
    if(currentPortfolioName == null) {
      await setToCurrentPortfolio(portfolioName);
    }
    emit(PortfolioList(await portfolioLocalRepository.getListPortfolio(), currentPortfolioName ?? portfolioName));
  }

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
    => await portfolioLocalRepository.portfolioAlreadyExists(portfolioName);

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

  //#region Other

  Future<void> emitToPortfolioTransactionsState(String portfolioName, String idCoin) async {
    emit(PortfolioLoading());
    final Portfolio? portfolio = await portfolioLocalRepository.getPortfolioByName(portfolioName);
    final Asset assetModel = portfolio!.listAssets.firstWhere((element) => element.idCoin == idCoin);
    emit(PortfolioTransactions(assetModel.listTransactions));
  }

  List<Transaction> getListTransactionsById(Portfolio portfolio, String idCoin) {
    final List<Transaction> listTransactions = [];
    for(int i = 0; i < portfolio.listAssets.length; i++) {
      if (portfolio.listAssets[i].idCoin == idCoin) {
        listTransactions.addAll(portfolio.listAssets[i].listTransactions);
        break;
      }
    }
    return listTransactions;
  }

  Future<void> deleteTransactionByIndex(int listTransactionsLength, String portfolioName, int indexTransaction, String idCoin) async {
    emit(PortfolioLoading());
    if(listTransactionsLength == 1) {
      await portfolioLocalRepository.deleteAssetById(portfolioName, idCoin);
    }
    else{
      await portfolioLocalRepository.deleteTransactionByIndex(portfolioName, indexTransaction, idCoin);
      emitToPortfolioTransactionsState(portfolioName, idCoin);
    }
  }

  Future<void> editTransaction(String namePortfolio, int indexTransaction, Transaction newTransactionModel) async {
    emit(PortfolioLoading());
    await portfolioLocalRepository.editTransactionByIndex(namePortfolio, indexTransaction, newTransactionModel);
    emitToPortfolioTransactionsState(namePortfolio, newTransactionModel.idCoin);
  }

  //#endregion

  Future<String> portfolioToJson(String portfolioName) async {
    final Portfolio? portfolioModel = await portfolioLocalRepository.getPortfolioByName(portfolioName);
    return jsonEncode(portfolioModel!.toJson());
  }

  Future<void> portfolioFromJson(String jsonPortfolio, String portfolioName) async {
    final Portfolio portfolioModel = Portfolio.fromJson(json.decode(jsonPortfolio));
    await portfolioLocalRepository.setPortfolio(portfolioName, portfolioModel);
  }
}