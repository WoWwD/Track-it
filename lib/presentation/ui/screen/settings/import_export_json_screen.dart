import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_it/presentation/cubit/portfolio_cubit/portfolio_cubit.dart';
import 'package:track_it/service/constant/app_styles.dart';
import 'package:track_it/service/di.dart' as di;

class ImportExportJsonScreen extends StatelessWidget {
  const ImportExportJsonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PortfolioCubit>(
      create: (_) => di.getIt(),
      child: BlocBuilder<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
          final portfolioCubit = BlocProvider.of<PortfolioCubit>(context);

          return Scaffold(
            appBar: AppBar(title: const Text('Импорт / экспорт портфеля')),
            body: Center(
              child: Container(
                padding: AppStyles.mainPadding,
                constraints: const BoxConstraints(maxWidth: AppStyles.maxWidth),
                child: Column(
                  children: [
                    _card(
                      context,
                      'Импортировать JSON из буфера обмена',
                      () async => await showDialog(
                        context: context,
                        builder: (context) => _dialog(context, portfolioCubit)
                      )
                    ),

                    const SizedBox(height: 16),
                    _card(
                      context,
                      'Экспортировать JSON в буфер обмена',
                      () => _toJson(context, portfolioCubit),
                      false
                    ),
                  ],
                )
              ),
            )
          );
        },
      )
    );
  }

  Widget _card(BuildContext context, String text, Function() onTap, [bool isImport = true]) {
    return ListTile(
      leading: SizedBox(
        height: double.infinity,
        child: isImport? const Icon(Icons.download): const Icon(Icons.upload)
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)),
      onTap: onTap,
      title: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        alignment: Alignment.centerLeft,
        child: Text(text)
      ),
    );
  }

  Widget _dialogButton(Function() onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text)
    );
  }

  Widget _dialog(BuildContext context, PortfolioCubit portfolioCubit) {
    return AlertDialog(
      title: const Text('Добавить портфель?'),
      content: const Text('Текущий портфель будет заменён'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _dialogButton(
              () {
                Navigator.pop(context);
                _fromJson(context, portfolioCubit);
              },
              'Да'
            ),
            const SizedBox(width: 24),
            _dialogButton(() => Navigator.pop(context), 'Нет'),
          ],
        ),
      ],
    );
  }

  Future<void> _toJson(BuildContext context, PortfolioCubit portfolioCubit, [bool mounted = true]) async {
    final String? portfolioName = await portfolioCubit.getCurrentPortfolioName();
    if(portfolioName != null) {
      await Clipboard.setData(ClipboardData(text: await portfolioCubit.portfolioToJson(portfolioName)));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('JSON скопирован в буфер обмена')));
    }
    else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Необходимо создать портфель')));
    }
  }

  Future<void> _fromJson(BuildContext context, PortfolioCubit portfolioCubit, [bool mounted = true]) async {
    try {
      final String? json = await Clipboard.getData(Clipboard.kTextPlain).then((value) => value?.text);
      final String? portfolioName = await portfolioCubit.getCurrentPortfolioName();
      if(portfolioName != null) {
        await portfolioCubit.portfolioFromJson(json ?? '', portfolioName);
      }
      else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Заменяемый портфель нужно сделать текущим')));
      }
    }
    on FormatException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Неверный формат')));
    }
  }
}
