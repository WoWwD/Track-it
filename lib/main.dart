import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:track_it/presentation/cubit/portfolio_cubit/portfolio_cubit.dart';
import 'package:track_it/presentation/provider/settings_model.dart';
import 'package:track_it/service/di.dart' as di;
import 'app.dart';

Future<void> main() async {
  await di.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsModel>(create: (_) => di.getIt()..getValueTheme()),
        BlocProvider<PortfolioCubit>(create: (_) => di.getIt()..getCoins())
      ],
      child: const App()
    )
  );
}