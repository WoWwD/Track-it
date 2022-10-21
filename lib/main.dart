import 'package:flutter/cupertino.dart';
import 'package:track_it/service/di/di.dart' as di;
import 'app.dart';

Future<void> main() async {
  await di.init();
  runApp(const App());
}