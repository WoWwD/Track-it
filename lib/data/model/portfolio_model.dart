import 'package:track_it/data/model/asset_model.dart';

class Portfolio {
  final String name;
  final List<Asset> listAssets;

  Portfolio({required this.name, required this.listAssets});

  factory Portfolio.fromJson(Map<String, dynamic> json) {
    final List<Asset> listAssets = [];
    json['listAssets'].forEach((item) {
      listAssets.add(Asset.fromJson(item));
    });

    return Portfolio(
      name: json['name'],
      listAssets: listAssets,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['listAssets'] = listAssets.map((item) => item.toJson()).toList();
    return data;
  }
}