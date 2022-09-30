import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:track_it/data/repository/coin_repository.dart';
import 'package:track_it/presentation/cubit/portfolio_cubit/portfolio_cubit.dart';
import '../../data/remote_data/api/coin_api.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  final Dio dio = Dio();
  final CoinApi coinApi = CoinApi(dio);
  final CoinRepository coinRepository = CoinRepository(coinApi);

  getIt.registerLazySingleton(() => coinRepository);

  //region Cubit
  getIt.registerLazySingleton<PortfolioCubit>(() =>
    PortfolioCubit(
     coinRepository: getIt.call()
    )
  );
}