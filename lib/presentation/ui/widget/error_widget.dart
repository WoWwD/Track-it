import 'package:flutter/material.dart';
import 'package:track_it/service/exception/app_exception.dart';

class ErrorWidget extends StatelessWidget {
  final AppException appException;

  const ErrorWidget({Key? key, required this.appException}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(appException.errorMessage);
  }
}