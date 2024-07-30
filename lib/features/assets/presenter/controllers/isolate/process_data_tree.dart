import 'package:tractian_test/features/assets/infra/models/asset_model.dart';
import 'package:tractian_test/features/assets/infra/models/location_model.dart';

class ProcessDataTree {
  static Future<Map<String, dynamic>> buildTreeInIsolate(Map<String, dynamic> data) async {
    List<Location> locations = (data['locations'] as List).map((e) => Location.fromJson(e)).toList();
    List<Asset> assets = (data['assets'] as List).map((e) => Asset.fromJson(e)).toList();
    String textSearch = data['textSearch'];

    Map<String, Asset> assetMap = await _buildAssetMap(textSearch, assets);
    Map<String, Location> locationMap = await _buildLocationMap(textSearch, locations, assetMap);

    await _associateAssetsToLocations(assetMap, locationMap);

    return {
      'rootLocations': locationMap.values.where((location) => location.parentId == null).map((e) => e.toJson()).toList(),
      'rootAssets': assetMap.values.where((asset) => asset.parentId == null && asset.locationId == null).map((e) => e.toJson()).toList(),
    };
  }

  static Future<Map<String, Location>> _buildLocationMap(String textSearch, List<Location> locations, Map<String, Asset> assetMap) async {
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

  static Future<Map<String, Asset>> _buildAssetMap(String textSearch, List<Asset> assets) async {
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

  static Future<void> _associateAssetsToLocations(Map<String, Asset> assetMap, Map<String, Location> locationMap) async {
    for (var asset in assetMap.values) {
      if (asset.locationId != null) {
        locationMap[asset.locationId]?.assets.add(asset);
      }
    }
  }
}