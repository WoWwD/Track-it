import 'package:flutter/material.dart';
import '../../../../service/constant/app_styles.dart';

class SearchCoinCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String symbol;
  final VoidCallback onTap;

  const SearchCoinCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.symbol,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)),
      leading: SizedBox(width: 36, height: 36, child: Image.network(imageUrl)),
      title: Text(name),
      subtitle: Text(symbol, style: const TextStyle(fontSize: 10)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }
}