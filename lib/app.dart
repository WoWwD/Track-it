import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_it/app_routes.dart';
import 'package:track_it/presentation/cubit/error_cubit/error_cubit.dart';
import 'package:track_it/presentation/ui/screen/main_screen.dart';
import 'package:track_it/service/di/di.dart' as di;

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.getIt<ErrorCubit>()),
        ],
        child: const MainScreen(),
      ),
      routes: AppRoutes.getRoutes(),
    );
  }
}