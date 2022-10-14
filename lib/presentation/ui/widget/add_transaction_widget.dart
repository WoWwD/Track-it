import 'package:flutter/material.dart';
import 'package:track_it/theme/app_styles.dart';
import 'button/icon_button_widget.dart';

class AddTransactionWidget extends StatelessWidget {
  const AddTransactionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(18),
            child: IconButtonWidget(
              onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: TabBar(
              tabs: [
                Tab(child: Text('Покупка', style: AppStyles.ORDINARY14)),
                Tab(child: Text('Продажа', style: AppStyles.ORDINARY14)),
                Tab(child: Text('Ввод', style: AppStyles.ORDINARY14)),
                Tab(child: Text('Вывод', style: AppStyles.ORDINARY14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
