import 'dart:convert';
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

  @observable
  bool isLoading = false;

  @observable
  ObservableList<Asset> rootAssets = ObservableList<Asset>();
  @observable
  ObservableList<Location> rootLocations = ObservableList<Location>();

  List<Asset> assetListSaved = [];
  List<Location> locationListSaved = [];

  @observable
  String textSearch = '';

  @action
  setTextSearch(String text) async {
    textSearch = text;
    await _buildTree(List<Location>.from(locationListSaved), List<Asset>.from(assetListSaved));
  }

  @action
  Future<void> get({required String id}) async {
    final res = await useCase.call(id);
    res.fold((success) async {
      assetListSaved = List<Asset>.from(success.assets);
      locationListSaved = List<Location>.from(success.locations);
      await _buildTree(List<Location>.from(locationListSaved), List<Asset>.from(assetListSaved));
    }, (failure) {
      log(failure.message ?? '');
    });
  }

  @action
  Future<void> _buildTree(List<Location> locations, List<Asset> assets) async {
    isLoading = true;
    rootAssets.clear();
    rootLocations.clear();

    Map<String, Asset> assetMap = await _buildAssetMap(List<Asset>.from(assets));
    Map<String, Location> locationMap = await _buildLocationMap(List<Location>.from(locations), assetMap);

    await _associateAssetsToLocations(assetMap, locationMap);

    rootLocations.addAll(locationMap.values.where((location) => location.parentId == null));
    rootAssets.addAll(assetMap.values.where((asset) => asset.parentId == null && asset.locationId == null));

    rootAssets.sort((a, b) => b.children.length.compareTo(a.children.length));
    rootLocations.sort((a, b) {
      int aCount = a.subLocations.length + a.assets.length;
      int bCount = b.subLocations.length + b.assets.length;
      return bCount.compareTo(aCount);
    });

    isLoading = false;

  }

  Future<Map<String, Location>> _buildLocationMap(List<Location> locations, Map<String, Asset> assetMap) async {
    final Map<String, Location> locationMap = {};
    for (var location in locations) {
      location.subLocations.clear();
      location.assets.clear();
      locationMap[location.id] = location;
    }

    bool removed;
    do {
      int initialSize = locationMap.values.length;
      locationMap.removeWhere((id, location) {
        return !location.name.toLowerCase().contains(textSearch.toLowerCase()) &&
            !locationMap.values.any((item) => item.parentId == id) && !assetMap.values.any((item) => item.locationId == id);
      });
      removed = initialSize != locationMap.values.length;
    } while (removed);

    for (var location in locationMap.values) {
      if (location.parentId != null) {
        locationMap[location.parentId]?.subLocations.add(location);
      }
    }
    return locationMap;
  }

  Future<Map<String, Asset>> _buildAssetMap(List<Asset> assets) async {
    final Map<String, Asset> assetMap = {};
    for (var asset in assets) {
      asset.children.clear();
      assetMap[asset.id] = asset;
    }

    bool removed;
    do {
      int initialSize = assetMap.values.length;
      assetMap.removeWhere((id, asset) {
        return !asset.name.toLowerCase().contains(textSearch.toLowerCase()) &&
            !assetMap.values.any((item) => item.parentId == id);
      });
      removed = initialSize != assetMap.values.length;
    } while (removed);

    for (var asset in assetMap.values) {
      if (asset.parentId != null) {
        assetMap[asset.parentId]?.children.add(asset);
      }
    }
    return assetMap;
  }

  Future<void> _associateAssetsToLocations(Map<String, Asset> assetMap, Map<String, Location> locationMap) async {
    for (var asset in assetMap.values) {
      if (asset.locationId != null) {
        locationMap[asset.locationId]?.assets.add(asset);
      }
    }
  }
}