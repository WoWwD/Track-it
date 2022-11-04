import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/presentation/provider/transaction_model.dart';
import 'package:track_it/service/constant/app_styles.dart';
import 'package:track_it/service/extension/date_time_extension.dart';
import '../../../../service/transaction_type_enum.dart';
import '../../widget/button/primary_button_widget.dart';
import '../../widget/text_field/text_field_transaction_note_widget.dart';
import '../../widget/text_field/text_field_transaction_widget.dart';
import 'package:track_it/service/extension/string_extension.dart';
import 'package:track_it/service/di.dart' as di;

class NewTransactionScreen extends StatefulWidget {
  final TransactionType transactionType;
  final String portfolioName;
  final String idCoin;
  final Function refreshPreviousScreen;
  final Transaction? oldTransactionModel;
  final int? indexOldTransaction;
  final bool isEdit;

  const NewTransactionScreen({
    Key? key,
    required this.transactionType,
    required this.portfolioName,
    required this.idCoin,
    required this.refreshPreviousScreen,
    this.isEdit = false,
    this.oldTransactionModel,
    this.indexOldTransaction,
  }) : super(key: key);

  @override
  State<NewTransactionScreen> createState() => _NewTransactionScreenState();
}

class _NewTransactionScreenState extends State<NewTransactionScreen> with AutomaticKeepAliveClientMixin {
  TextEditingController? textEditingController;
  final _formKey = GlobalKey<FormState>();

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TransactionModel>(
      create: (_) {
        if(widget.isEdit) {
          return TransactionModel(
            portfolioLocalRepository: di.getIt(),
            transactionType: widget.transactionType,
            idCoin: widget.idCoin,
            portfolioName: widget.portfolioName
          )..initForEditing(widget.oldTransactionModel!);
        }
        else {
          return TransactionModel(
            portfolioLocalRepository: di.getIt(),
            transactionType: widget.transactionType,
            idCoin: widget.idCoin,
            portfolioName: widget.portfolioName
          );
        }
      },
      builder: (context, child) {
        final TransactionModel model = Provider.of<TransactionModel>(context);
        if (model.isBuyOrSell()) {
          textEditingController = TextEditingController(text: model.initTextEditingController());
        }

        return Form(
          key: _formKey,
          child: widget.isEdit
            ? _editWidget(model)
            : _mainWidget(model, widget.isEdit)
        );
      }
    );
  }

  Widget _editWidget(TransactionModel model) {
    return Scaffold(
      appBar: AppBar(title: const Text('Редактирование')),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: AppStyles.maxWidth),
          child: _mainWidget(model, widget.isEdit),
        )
      )
    );
  }

  Widget _mainWidget(TransactionModel model, bool isEdit) {
    return Padding(
      padding: AppStyles.mainPadding,
      child: Column(
        children: [
          const SizedBox(height: 24),
          TextFieldTransaction(
            labelText: 'Количество',
            onChanged: (value) {
              if (value.isNotEmpty) {
                model.setAmount(double.parse(value));
                model.isBuyOrSell() ? model.setCost() : null;
              }
            },
            initialValue: model.amount == 0.0 ? '' : model.amount.toString(),
          ),
          model.isBuyOrSell() ? _forTypeTransactionBuyAndSell(model) : const SizedBox(),
          _forAllTypeTransactions(model),
          const Expanded(child: SizedBox.shrink()),
          PrimaryButton(
            text: isEdit? 'Изменить': 'Добавить',
            onPressed: () {
              if(_formKey.currentState!.validate()){
                if(isEdit) {
                  model.editTransaction(widget.oldTransactionModel!, widget.indexOldTransaction!)
                    .then((value) => widget.refreshPreviousScreen());
                }
                else {
                  model.addTransaction()
                    .then((value) => widget.refreshPreviousScreen());
                }
                Navigator.pop(context);
              }
            }
          ),
        ]
      ),
    );
  }

  Widget _forAllTypeTransactions(TransactionModel model) {
    return Column(
      children: [
        const SizedBox(height: 24),
        DateTimePicker(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Дата'
          ),
          type: DateTimePickerType.dateTime,
          dateMask: 'dd.MM.yyyy - HH:mm',
          initialValue: model.dateTime.dateTimeFormatToString(),
          firstDate: DateTime(2008, 08, 01),
          lastDate: model.dateTime,
          onChanged: (value) => model.setDateTime(value.toDateTime()),
        ),
        const SizedBox(height: 24),
        TextFieldTransactionNote(
          initialValue: model.note,
          onChanged: (value) {
            if (value.isNotEmpty) {
              model.setNote(value);
            }
          },
        )
      ],
    );
  }

  Widget _forTypeTransactionBuyAndSell(TransactionModel model) {
    return Column(
      children: [
        const SizedBox(height: 24),
        TextFieldTransaction(
          textInputType: TextInputType.number,
          labelText: 'Цена',
          onChanged: (value) {
            if (value.isNotEmpty) {
              model.setPrice(double.parse(value));
              model.setCost();
            }
          },
          initialValue: model.price == 0.0 ? '' : model.price.toString(),
        ),
        const SizedBox(height: 24),
        TextFieldTransaction(
          readOnly: true,
          textInputType: TextInputType.number,
          labelText: 'Общая стоимость',
          controller: textEditingController,
        ),
      ],
    );
  }
}