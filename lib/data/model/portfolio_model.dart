import 'package:track_it/data/model/asset_model.dart';

class Portfolio {
  final String id;
  final String name;
  final List<Asset> listAssets;

  Portfolio({required this.id, required this.name, required this.listAssets});
}