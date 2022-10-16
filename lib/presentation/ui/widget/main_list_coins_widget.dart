import 'package:flutter/widgets.dart';
import 'package:track_it/presentation/ui/widget/card_coin_widget.dart';
import 'package:track_it/service/constant/app_constants_size.dart';
import '../../../data/model/coin/coin_model.dart';

class MainListCoins extends StatelessWidget {
  final List<Coin> coins;

  const MainListCoins({Key? key, required this.coins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: AppConstantsSize.MAX_WIDTH),
      child: ListView.builder(
        itemCount: coins.length,
        itemBuilder: (context, index) {
          return CardCoin(coinModel: coins[index]);
        }
      ),
    );
  }
}
