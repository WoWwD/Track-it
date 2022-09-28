import 'package:flutter/material.dart';
import 'package:track_it/data/model/coin_model.dart';
import 'package:track_it/service/constant/app_constants_size.dart';

class CardCoinWidget extends StatelessWidget {
  final Coin coinModel;

  const CardCoinWidget({Key? key, required this.coinModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppConstantsSize.MAX_WIDTH_CARD_COIN),
      child: Container(
        width: 200,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        child: Center(child: Text(coinModel.name)),
      ),
    );
  }
}
