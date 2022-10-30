import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_it/service/extension/string_extension.dart';
import '../../../../service/error/input_error.dart';
import '../../../cubit/portfolio_cubit/portfolio_cubit.dart';
import '../button/icon_button_widget.dart';
import '../text_field/primary_text_field.dart';

class CreatePortfolio extends StatefulWidget {
  final BuildContext contextCubit;

  const CreatePortfolio({Key? key, required this.contextCubit}) : super(key: key);

  @override
  State<CreatePortfolio> createState() => _CreatePortfolioState();
}

class _CreatePortfolioState extends State<CreatePortfolio> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final portfolioCubit = BlocProvider.of<PortfolioCubit>(widget.contextCubit);

    return Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 18, top: 18, bottom: 9),
          child: IconButtonV2(
            onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: PrimaryTextField(
                labelText: 'Название',
                onChanged: (value) => setState(() {
                  _textEditingController.text = value;
                }),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return InputError.empty;
                  }
                  if (value.toString().isMaxLength()) {
                    return InputError.maxLength;
                  }
                  return null;
                },
                suffixIcon: IconButtonV2(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if(!await portfolioCubit.portfolioAlreadyExists(_textEditingController.text)) {
                        await portfolioCubit.createPortfolio(_textEditingController.text);
                        if (!mounted) return;
                        Navigator.pop(context);
                      }
                    }
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            )
          )
        )
      ],
    );
  }
}
