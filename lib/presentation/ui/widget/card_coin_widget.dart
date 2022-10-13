import 'package:flutter/material.dart';
import 'package:track_it/data/model/coin_model.dart';

class CardCoinWidget extends StatelessWidget {
  final Coin coinModel;

  const CardCoinWidget({Key? key, required this.coinModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      child: Row(
        children: [
          SizedBox(width: 24, height: 24, child: Image.network(coinModel.image)),
          Text(coinModel.name),
          Text(coinModel.currentPrice.toString())
        ],
      ),
    );
  }
}
