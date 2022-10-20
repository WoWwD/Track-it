import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:track_it/service/di/di.dart' as di;
import 'app.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
 // Hive.init((await getApplicationDocumentsDirectory()).path);
  await di.init();
  runApp(const App());
}