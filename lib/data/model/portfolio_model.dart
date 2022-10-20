import 'package:hive/hive.dart';
import 'package:track_it/data/model/asset_model.dart';

@HiveType(typeId: 0)
class Portfolio extends HiveObject {

  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<Asset> listAssets;

  Portfolio({required this.name, required this.listAssets});
}