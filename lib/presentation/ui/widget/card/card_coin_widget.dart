import 'package:flutter/material.dart';
import 'package:track_it/service/extension/double_extension.dart';
import '../../../../theme/app_styles.dart';

class CardCoin extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String symbol;
  final double price;
  final VoidCallback onTap;

  const CardCoin({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.symbol,
    required this.price,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)),
      leading: SizedBox(width: 36, height: 36, child: Image.network(imageUrl)),
      title: Text(name),
      subtitle: Text(symbol.toUpperCase(), style: const TextStyle(fontSize: 10)),
      trailing: Text('\$${price.noZero()}'),
      onTap: onTap,
    );
  }
}
