import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:track_it/data/local_data/portfolio_local_data.dart';
import 'package:track_it/data/repository/remote_repository/coin_remote_repository.dart';
import 'package:track_it/presentation/cubit/coin_cubit/coin_cubit.dart';
import 'package:track_it/presentation/cubit/error_cubit/error_cubit.dart';
import 'package:track_it/presentation/cubit/portfolio_cubit/portfolio_cubit.dart';
import 'package:track_it/presentation/cubit/search_cubit/search_cubit.dart';
import 'package:track_it/presentation/cubit/transaction_cubit/transaction_cubit.dart';
import '../../data/remote_data/coin_remote_data.dart';
import '../../data/repository/local_repository/portfolio_local_repository.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  final Dio dio = Dio();
  final CoinRemoteData coinRemoteData = CoinRemoteData(dio);
  final PortfolioLocalData portfolioLocalData = PortfolioLocalData();
  final CoinRemoteRepository coinRemoteRepository = CoinRemoteRepository(coinRemoteData);
  final PortfolioLocalRepository portfolioLocalRepository = PortfolioLocalRepository(portfolioLocalData);

  //region Repository
  getIt.registerLazySingleton(() => coinRemoteRepository);
  getIt.registerLazySingleton(() => portfolioLocalRepository);

  //region Cubit
  getIt.registerLazySingleton<PortfolioCubit>(() => PortfolioCubit(portfolioLocalRepository: getIt.call()));
  getIt.registerLazySingleton<CoinCubit>(() => CoinCubit(coinRepository: getIt.call()));
  getIt.registerLazySingleton<ErrorCubit>(() => ErrorCubit());
  getIt.registerFactory(() => SearchCubit(coinRemoteRepository: getIt.call()));
  getIt.registerFactory(() => TransactionCubit(coinRemoteRepository: getIt.call()));
}