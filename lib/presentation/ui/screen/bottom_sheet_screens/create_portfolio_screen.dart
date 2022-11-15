import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_it/service/extensions/string_extension.dart';
import '../../../../service/errors/input_error.dart';
import '../../../cubit/portfolio_cubit/portfolio_cubit.dart';
import '../../widget/button/icon_button_widget.dart';
import '../../widget/text_field/primary_text_field.dart';
import 'package:track_it/service/di.dart' as di;

class CreatePortfolioScreen extends StatefulWidget {
  final Function refreshState;

  const CreatePortfolioScreen({Key? key, required this.refreshState}) : super(key: key);

  @override
  State<CreatePortfolioScreen> createState() => _CreatePortfolioScreenState();
}

class _CreatePortfolioScreenState extends State<CreatePortfolioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider<PortfolioCubit>(
        create: (_) => di.getIt<PortfolioCubit>(),
        child: BlocBuilder<PortfolioCubit, PortfolioState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16, top: 16),
                child: Form(
                  key: _formKey,
                  child: PrimaryTextField(
                    labelText: 'Название',
                    onChanged: (value) => setState(() {
                      _textEditingController.text = value;
                    }),
                    validator: (value) => _validator(value ?? ''),
                    suffixIcon: IconButtonV2(
                      onPressed: () => _createPortfolio(context),
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                )
              ),
            );
          },
        ),
      ),
    );
  }

  String? _validator(String value) {
    if (value.toString().isEmpty) {
      return InputError.empty;
    }
    if (value.toString().isMaxLength()) {
      return InputError.maxLength;
    }
    return null;
  }

  void _createPortfolio(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final bool? portfolioAlreadyExists =
        await context.read<PortfolioCubit>().portfolioAlreadyExists(_textEditingController.text);
      if (portfolioAlreadyExists == null || !portfolioAlreadyExists) {
        if (!mounted) return;
        await context.read<PortfolioCubit>().createPortfolio(_textEditingController.text);
        widget.refreshState();
        if (!mounted) return;
        Navigator.pop(context);
      }
    }
  }
}