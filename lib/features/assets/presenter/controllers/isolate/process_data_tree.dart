import 'package:tractian_test/features/assets/infra/enum/status_asset_enum.dart';
import 'package:tractian_test/features/assets/infra/models/asset_model.dart';
import 'package:tractian_test/features/assets/infra/models/location_model.dart';

class ProcessDataTree {
  static Future<Map<String, dynamic>> buildTreeInIsolate(Map<String, dynamic> data) async {
    List<Location> locations = (data['locations'] as List).map((e) => Location.fromJson(e)).toList();
    List<Asset> assets = (data['assets'] as List).map((e) => Asset.fromJson(e)).toList();
    String textSearch = data['textSearch'];
    bool isCritic = data['isCritic'];
    List<String> sensorTypeSelectedList = data['sensorsType'];

    Map<String, Asset> assetMap = await _buildAssetMap(textSearch, isCritic, sensorTypeSelectedList, assets);
    bool filterActive = isCritic || sensorTypeSelectedList.isNotEmpty;
    Map<String, Location> locationMap = await _buildLocationMap(textSearch, filterActive, locations, assetMap);

    _associateAssetsToLocations(assetMap, locationMap);

    return {
      'rootLocations': locationMap.values.where((location) => location.parentId == null).map((e) => e.toJson()).toList(),
      'rootAssets': assetMap.values.where((asset) => asset.parentId == null && asset.locationId == null).map((e) => e.toJson()).toList(),
    };
  }

  static Future<Map<String, Location>> _buildLocationMap(String textSearch, bool filterActive, List<Location> locations, Map<String, Asset> assetMap) async {
    final Map<String, Location> locationMap = { for (var location in locations) location.id: location..subLocations.clear()..assets.clear() };

    _removeUnmatchedLocations(textSearch, filterActive, locationMap, assetMap);

    for (var location in locationMap.values) {
      if (location.parentId != null) {
        locationMap[location.parentId]?.subLocations.add(location);
      }
    }
    return locationMap;
  }

  static Future<Map<String, Asset>> _buildAssetMap(String textSearch, bool isCritic, List<String> sensorTypeSelectedList, List<Asset> assets) async {
    final Map<String, Asset> assetMap = { for (var asset in assets) asset.id: asset..children.clear() };

    _removeUnmatchedAssets(textSearch, isCritic, sensorTypeSelectedList, assetMap);

    for (var asset in assetMap.values) {
      if (asset.parentId != null) {
        assetMap[asset.parentId]?.children.add(asset);
      }
    }
    return assetMap;
  }

  static void _associateAssetsToLocations(Map<String, Asset> assetMap, Map<String, Location> locationMap) {
    for (var asset in assetMap.values) {
      if (asset.locationId != null) {
        locationMap[asset.locationId]?.assets.add(asset);
      }
    }
  }

  static void _removeUnmatchedLocations(String textSearch, bool filterActive, Map<String, Location> locationMap, Map<String, Asset> assetMap) {
    bool removed;
    do {
      int initialSize = locationMap.values.length;
      locationMap.removeWhere((id, location) =>
      ((!location.name.toLowerCase().contains(textSearch.toLowerCase()) || filterActive) &&
          !locationMap.values.any((item) => item.parentId == id) &&
          !assetMap.values.any((item) => item.locationId == id))
      );
      removed = initialSize != locationMap.values.length;
    } while (removed);
  }

  static void _removeUnmatchedAssets(String textSearch, bool isCriticActive, List<String> sensorTypeSelectedList, Map<String, Asset> assetMap) {
    bool removed;
    do {
      int initialSize = assetMap.values.length;
      assetMap.removeWhere((id, asset) =>
      (!asset.name.toLowerCase().contains(textSearch.toLowerCase()) ||
          (!sensorTypeSelectedList.contains(asset.sensorType) && sensorTypeSelectedList.isNotEmpty) ||
          (isCriticActive && !StatusAssetExtension.isCritic(asset.status))) &&
          !assetMap.values.any((item) => item.parentId == id)
      );
      removed = initialSize != assetMap.values.length;
    } while (removed);
  }
}
