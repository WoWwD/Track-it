import 'package:flutter/material.dart';
import 'package:track_it/presentation/ui/widget/primary_dialog_widget.dart';
import '../../../../service/constants/app_styles.dart';

class CardPortfolio extends StatelessWidget {
  final String portfolioName;
  final int amountAssets;
  final bool isCurrent;
  final Function() deletePortfolio;
  final Function() onChanged;

  const CardPortfolio({
    Key? key,
    required this.portfolioName,
    required this.amountAssets,
    required this.isCurrent,
    required this.deletePortfolio,
    required this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)),
      title: Text(portfolioName),
      subtitle: Text('Количество монет: $amountAssets'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isCurrent
            ? _button(context, onChanged, Colors.green, 'Текущий', Icons.check)
            : _button(context, onChanged, Colors.grey, 'Выбрать', null),
          _button(
            context,
            () => showDialog(
              context: context,
              builder: (context) => PrimaryDialog(
                onPressedConfirm: () {
                  deletePortfolio();
                  Navigator.pop(context);
                },
                title: 'Удалить портфель?',
              )
            ),
            Colors.redAccent,
            'Удалить',
            Icons.delete
          ),
        ],
      ),
    );
  }

  Widget _button(BuildContext context, void Function()? onTap, Color color, String text, IconData? icon) {
    final double borderRadius = color == Colors.redAccent? AppStyles.borderRadiusApp: 0.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius)
          )
        ),
        child: SizedBox(
          width: 64,
          height: MediaQuery.of(context).size.height,
          child: icon == null
            ? Center(child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.white)))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white),
                  Text(text, style: const TextStyle(fontSize: 12, color: Colors.white))
                ],
              ),
        ),
      ),
    );
  }
}