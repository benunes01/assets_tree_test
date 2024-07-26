import 'dart:convert';

import 'package:tractian_test/features/assets/infra/models/asset_model.dart';
import 'package:tractian_test/features/assets/infra/models/location_model.dart';

class GetAssetsResponse {
  List<Location> locations;
  List<Asset> assets;

  GetAssetsResponse({
    required this.locations,
    required this.assets,
  });

  Map<String, dynamic> toMap() {
    return {
      'locations': locations.map((location) => location.toMap()).toList(),
      'assets': assets.map((asset) => asset.toMap()).toList(),
    };
  }

  factory GetAssetsResponse.fromMap(Map<String, dynamic> map) {
    return GetAssetsResponse(
      locations: List<Location>.from(map['locations']?.map((locationMap) => Location.fromMap(locationMap)) ?? []),
      assets: List<Asset>.from(map['assets']?.map((assetMap) => Asset.fromMap(assetMap)) ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAssetsResponse.fromJson(String source) => GetAssetsResponse.fromMap(json.decode(source));

  GetAssetsResponse copyWith({
    List<Location>? locations,
    List<Asset>? assets,
  }) {
    return GetAssetsResponse(
      locations: locations ?? this.locations,
      assets: assets ?? this.assets,
    );
  }
}