import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:track_it/data/local_data/portfolio_local_data.dart';
import 'package:track_it/presentation/cubit/portfolio_cubit/portfolio_cubit.dart';
import 'package:track_it/presentation/cubit/search_cubit/search_cubit.dart';
import 'package:track_it/presentation/cubit/statistics_cubit/statistics_cubit.dart';
import 'package:track_it/presentation/provider/settings_model.dart';
import 'package:track_it/presentation/provider/transaction_model.dart';
import '../data/remote_data/coin_remote_data.dart';
import '../domain/repository/local_repository/portfolio_local_repository.dart';
import '../domain/repository/remote_repository/coin_remote_repository.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  final Dio dio = Dio();
  final CoinRemoteData coinRemoteData = CoinRemoteData(dio);
  final PortfolioLocalData portfolioLocalData = PortfolioLocalData();
  final CoinRemoteRepository coinRemoteRepository = CoinRemoteRepository(coinRemoteData);
  final PortfolioLocalRepository portfolioLocalRepository = PortfolioLocalRepository(portfolioLocalData);

  //region Data
  getIt.registerLazySingleton(() => coinRemoteData);
  getIt.registerLazySingleton(() => portfolioLocalData);

  //region Repository
  getIt.registerLazySingleton(() => coinRemoteRepository);
  getIt.registerLazySingleton(() => portfolioLocalRepository);

  //region Provider
  getIt.registerFactory<TransactionModel>(() => TransactionModel(portfolioLocalRepository: getIt.call()));
  getIt.registerLazySingleton(() => SettingsModel(portfolioLocalRepository: getIt.call()));

  //region Cubit
  getIt.registerFactory<PortfolioCubit>(
    () => PortfolioCubit(portfolioLocalRepository: getIt.call(), coinRemoteRepository: getIt.call())
  );
  getIt.registerFactory<StatisticsCubit>(() => StatisticsCubit(portfolioLocalRepository: getIt.call()));
  getIt.registerFactory<SearchCubit>(() => SearchCubit(coinRemoteRepository: getIt.call()));
}