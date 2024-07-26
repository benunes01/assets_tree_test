import 'dart:developer';

import 'package:mobx/mobx.dart';
import 'package:tractian_test/features/assets/domain/usecases/get_asset_usecase.dart';
import 'package:tractian_test/features/assets/infra/models/asset_model.dart';
import 'package:tractian_test/features/assets/infra/models/location_model.dart';

part 'asset_controller.g.dart';

class AssetController = AssetControllerBase with _$AssetController;

abstract class AssetControllerBase with Store {
  final GetAssetUseCase useCase;

  AssetControllerBase({required this.useCase});

  ObservableList<Asset> rootAssets = ObservableList<Asset>();
  ObservableList<Location> rootLocations = ObservableList<Location>();

  @action
  Future<void> get({required String id}) async {
    final res = await useCase.call(id);
    res.fold((success) {
      _buildTree(success.locations, success.assets);
    }, (failure) {
      log(failure.message ?? '');
    });
  }

  void _buildTree(List<Location> locations, List<Asset> assets) {
    rootAssets.clear();
    rootLocations.clear();

    final locationMap = _buildLocationMap(locations);
    final assetMap = _buildAssetMap(assets);

    _associateAssetsToLocations(assetMap, locationMap);

    rootLocations.addAll(locationMap.values.where((location) => location.parentId == null));
    rootAssets.addAll(assetMap.values.where((asset) => asset.parentId == null && asset.locationId == null));
  }

  Map<String, Location> _buildLocationMap(List<Location> locations) {
    final Map<String, Location> locationMap = {};
    for (var location in locations) {
      locationMap[location.id] = location;
    }
    for (var location in locations) {
      if (location.parentId != null) {
        locationMap[location.parentId]?.subLocations.add(location);
      }
    }
    return locationMap;
  }

  Map<String, Asset> _buildAssetMap(List<Asset> assets) {
    final Map<String, Asset> assetMap = {};
    for (var asset in assets) {
      assetMap[asset.id] = asset;
    }
    for (var asset in assets) {
      if (asset.parentId != null) {
        assetMap[asset.parentId]?.children.add(asset);
      }
    }
    return assetMap;
  }

  void _associateAssetsToLocations(Map<String, Asset> assetMap, Map<String, Location> locationMap) {
    for (var asset in assetMap.values) {
      if (asset.locationId != null) {
        locationMap[asset.locationId]?.assets.add(asset);
      }
    }
  }
}
