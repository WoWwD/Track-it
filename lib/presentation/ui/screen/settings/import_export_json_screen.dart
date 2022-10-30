import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:track_it/presentation/provider/settings_model.dart';
import 'package:track_it/service/constant/app_constants.dart';
import 'package:track_it/service/constant/app_styles.dart';

class ImportExportJsonScreen extends StatelessWidget {
  final String portfolioName = AppConstants.mainPortfolioStorage;

  const ImportExportJsonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Импорт / экспорт портфеля')),
      body: Consumer<SettingsModel>(
        builder: (context, model, child) {
          return Center(
            child: Container(
              padding: AppStyles.mainPadding,
              constraints: const BoxConstraints(maxWidth: AppStyles.maxWidth),
              child: Column(
                children: [
                  _card(
                    context,
                    'Импортировать JSON из буфера обмена',
                    () async => await showDialog(context: context,builder: (context) => _dialog(context, model))
                  ),

                  const SizedBox(height: 16),
                  _card(
                    context,
                    'Экспортировать JSON в буфер обмена',
                    () => _toJson(context, model),
                    false
                  ),
                ],
              )
            ),
          );
        },
      ),
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

  Widget _dialog(BuildContext context, SettingsModel model) {
    return AlertDialog(
      title: const Text('Добавить новый портфель?'),
      content: const Text('Текущий портфель будет удалён'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _dialogButton(
              () {
                Navigator.pop(context);
                _fromJson(context, model);
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

  Future<void> _toJson(BuildContext context, SettingsModel model) async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('JSON скопирован в буфер обмена')));
    await Clipboard.setData(ClipboardData(text: await model.portfolioToJson(portfolioName)));
  }

  Future<void> _fromJson(BuildContext context, SettingsModel model, [bool mounted = true]) async {
    try {
      final String? json = await Clipboard.getData(Clipboard.kTextPlain).then((value) => value?.text);
      await model.portfolioFromJson(json ?? '', portfolioName);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Портфель добавлен')));
    }
    on FormatException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Неверный формат')));
    }
  }
}
