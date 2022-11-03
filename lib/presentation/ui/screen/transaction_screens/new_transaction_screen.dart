import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/presentation/provider/transaction_model.dart';
import 'package:track_it/presentation/ui/widget/button/primary_button_widget.dart';
import 'package:track_it/service/constant/app_styles.dart';
import 'package:track_it/service/extension/date_time_extension.dart';
import '../../../../service/transaction_type_enum.dart';
import '../../widget/text_field/text_field_transaction_note_widget.dart';
import '../../widget/text_field/text_field_transaction_widget.dart';
import 'package:track_it/service/extension/string_extension.dart';

class AddTransactionScreen extends StatefulWidget {
  final String? portfolioName;
  final int? indexTransaction;
  final Transaction? oldTransactionModel;
  final TransactionModel model;
  final TransactionType transactionType;
  final bool isEdit;

  const AddTransactionScreen({
    Key? key,
    required this.model,
    required this.transactionType,
    this.isEdit = false,
    this.portfolioName,
    this.indexTransaction,
    this.oldTransactionModel
  }) : super(key: key);

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  TextEditingController? textEditingController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if(_isBuyOrSell()) {
      textEditingController = TextEditingController(
        text: widget.model.price * widget.model.amount == 0.0? '': '\$${(widget.model.price * widget.model.amount)}'
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.isEdit) {
      return Scaffold(
        appBar: AppBar(title: const Text('Редактирование')),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: AppStyles.maxWidth),
            child: Column(
              children: [
                Expanded(child: Form(key: _formKey, child: _mainWidget())),
                PrimaryButton(
                  text: 'Изменить',
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      widget.model.editTransaction(
                        widget.portfolioName!,
                        widget.indexTransaction!,
                        widget.oldTransactionModel!
                      );
                      Navigator.pop(context);
                    }
                  }
                ),
                const SizedBox(height: 16)
              ],
            ),
          )
        )
      );
    }
    else {
      return _mainWidget();
    }
  }

  Widget _mainWidget() {
    return Padding(
      padding: AppStyles.mainPadding,
      child: Column(
        children: [
          const SizedBox(height: 24),
          TextFieldTransaction(
            labelText: 'Количество',
            onChanged: (value) {
              if (value.isNotEmpty) {
                widget.model.setAmount(double.parse(value));
                _isBuyOrSell()? setCost(textEditingController!, widget.model): null;
              }
            },
            initialValue: widget.model.amount == 0.0? '': widget.model.amount.toString(),
          ),
          _isBuyOrSell()? _forTypeTransactionBuyAndSell(): const SizedBox(),
          _forAllTypeTransactions()
        ]
      ),
    );
  }

  Widget _forAllTypeTransactions() {
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
          initialValue: widget.model.dateTime.dateTimeFormatToString(),
          firstDate: DateTime(2008, 08, 01),
          lastDate: widget.model.dateTime,
          onChanged: (value) => widget.model.setDateTime(value.toDateTime()),
        ),
        const SizedBox(height: 24),
        TextFieldTransactionNote(
          initialValue: widget.model.note,
          onChanged: (value) {
            if (value.isNotEmpty) {
              widget.model.setNote(value);
            }
          },
        )
      ],
    );
  }

  Widget _forTypeTransactionBuyAndSell() {
    return Column(
      children: [
        const SizedBox(height: 24),
        TextFieldTransaction(
          textInputType: TextInputType.number,
          labelText: 'Цена',
          onChanged: (value) {
            if (value.isNotEmpty) {
              widget.model.setPrice(double.parse(value));
              setCost(textEditingController!, widget.model);
            }
          },
          initialValue: widget.model.price == 0.0? '': widget.model.price.toString(),
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

  bool _isBuyOrSell()
    => widget.transactionType == TransactionType.buy || widget.transactionType == TransactionType.sell;

  void setCost(TextEditingController tec, TransactionModel transactionModel) {
    setState(() {
      if(transactionModel.price * transactionModel.amount == 0.0) {
        tec.text = '';
      }
      else {
        transactionModel.setCost(transactionModel.price * transactionModel.amount);
        tec.text = '\$${(transactionModel.price * transactionModel.amount)}';
      }
    });
  }
}
