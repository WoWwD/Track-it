import 'package:track_it/service/transaction_type_enum.dart';

import 'constant/app_constants.dart';

class Helpers {
  static String createStringFromItemsList(List<String> list) {
    String res = '';
    for (String item in list) {
      res += '$item,';
    }
    return res;
  }

  static String getTypeTransactionFromModel(String typeOfTransaction) {
    switch (typeOfTransaction) {
      case AppConstants.buyTypeTransaction: return 'Покупка';
      case AppConstants.sellTypeTransaction: return 'Продажа';
      case AppConstants.transferInTypeTransaction: return 'Ввод';
      case AppConstants.transferOutTypeTransaction: return 'Вывод';
    }
    return '';
  }

  static String setTypeTransactionToModel(TransactionType transactionType) {
    switch(transactionType) {
      case TransactionType.buy: return AppConstants.buyTypeTransaction;
      case TransactionType.sell: return AppConstants.sellTypeTransaction;
      case TransactionType.transferIn: return AppConstants.transferInTypeTransaction;
      case TransactionType.transferOut: return AppConstants.transferOutTypeTransaction;
    }
  }
}