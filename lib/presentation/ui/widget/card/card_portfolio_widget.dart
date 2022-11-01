import 'package:flutter/material.dart';
import '../../../../service/constant/app_styles.dart';

class CardPortfolio extends StatelessWidget {
  final String portfolioName;
  final int amountAssets;
  final bool isCurrent;
  final Function() deletePortfolio;
  final ValueChanged<bool?>? onChanged;

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
          _checkBox(),
          const SizedBox(width: 12),
          _deleteButton(context),
        ],
      ),
    );
  }

  Widget _deleteButton(BuildContext context) {
    return GestureDetector(
      onTap: deletePortfolio,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppStyles.borderRadiusApp),
            bottomRight: Radius.circular(AppStyles.borderRadiusApp)
          )
        ),
        child: SizedBox(
          width: 64,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.delete, color: Colors.white),
              Text('Удалить', style: TextStyle(fontSize: 12, color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }

  Widget _checkBox() {
    return Column(
      children: [
        Checkbox(value: isCurrent, onChanged: onChanged),
        Text(isCurrent? 'Текущий': 'Выбрать', style: const TextStyle(fontSize: 12, color: Colors.white))
      ],
    );
  }
}