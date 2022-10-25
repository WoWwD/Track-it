import 'package:flutter/material.dart';
import 'package:track_it/data/model/coin/market_coin_model.dart';
import 'package:track_it/presentation/ui/widget/card/transaction_card_widget.dart';
import 'package:track_it/service/constant/app_constants_size.dart';
import '../../../data/model/transaction_model.dart';
import '../../../theme/app_styles.dart';

class InfoAssetScreen extends StatelessWidget {
  final MarketCoin marketCoinModel;
  final List<Transaction> listTransactions;

  const InfoAssetScreen({
    Key? key,
    required this.marketCoinModel,
    required this.listTransactions
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: Image.network(marketCoinModel.image, width: 36, height: 36),
          title: Text('${marketCoinModel.name} #${marketCoinModel.marketCapRank}'),
          subtitle: Text(marketCoinModel.symbol.toUpperCase(), style: const TextStyle(fontSize: 10)),
        ),
      ),
      body: Center(
        child: Container(
          padding: AppStyles.paddingScreen,
          constraints: const BoxConstraints(maxWidth: AppConstantsSize.MAX_WIDTH),
          child: Column(
            children: [
              const Text('Список транзакций:'),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  padding: AppStyles.paddingListView,
                  itemCount: listTransactions.length,
                  itemBuilder: (context, index) {
                    return TransactionCard(
                      transactionModel: listTransactions[index],
                      onPressed: (BuildContext context) => print('удалил'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
