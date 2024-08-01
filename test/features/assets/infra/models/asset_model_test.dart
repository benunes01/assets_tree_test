import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_test/features/assets/infra/models/asset_model.dart';
import 'dart:convert';

void main() {
  group('Asset Model', () {
    final asset = Asset(
      name: 'Asset 1',
      id: '1',
      locationId: 'loc1',
      parentId: 'parent1',
      sensorType: 'sensor1',
      status: 'active',
      children: [
        Asset(
          name: 'Child Asset',
          id: '2',
        ),
      ],
    );

    test('toMap returns correct map', () {
      final map = asset.toMap();
      expect(map, {
        'name': 'Asset 1',
        'id': '1',
        'locationId': 'loc1',
        'parentId': 'parent1',
        'sensorType': 'sensor1',
        'status': 'active',
        'children': [
          {
            'name': 'Child Asset',
            'id': '2',
            'locationId': null,
            'parentId': null,
            'sensorType': null,
            'status': null,
            'children': []
          }
        ],
      });
    });

    test('fromMap creates correct Asset', () {
      final map = {
        'name': 'Asset 1',
        'id': '1',
        'locationId': 'loc1',
        'parentId': 'parent1',
        'sensorType': 'sensor1',
        'status': 'active',
        'children': [
          {
            'name': 'Child Asset',
            'id': '2',
            'locationId': null,
            'parentId': null,
            'sensorType': null,
            'status': null,
            'children': []
          }
        ],
      };
      final assetFromMap = Asset.fromMap(map);
      expect(assetFromMap.name, asset.name);
      expect(assetFromMap.id, asset.id);
      expect(assetFromMap.locationId, asset.locationId);
      expect(assetFromMap.parentId, asset.parentId);
      expect(assetFromMap.sensorType, asset.sensorType);
      expect(assetFromMap.status, asset.status);
      expect(assetFromMap.children.length, asset.children.length);
      expect(assetFromMap.children[0].name, asset.children[0].name);
    });

    test('toJson returns correct JSON string', () {
      final jsonStr = asset.toJson();
      expect(jsonStr, json.encode(asset.toMap()));
    });

    test('fromJson creates correct Asset', () {
      final jsonStr = json.encode(asset.toMap());
      final assetFromJson = Asset.fromJson(jsonStr);
      expect(assetFromJson.name, asset.name);
      expect(assetFromJson.id, asset.id);
      expect(assetFromJson.locationId, asset.locationId);
      expect(assetFromJson.parentId, asset.parentId);
      expect(assetFromJson.sensorType, asset.sensorType);
      expect(assetFromJson.status, asset.status);
      expect(assetFromJson.children.length, asset.children.length);
      expect(assetFromJson.children[0].name, asset.children[0].name);
    });

    test('copyWith creates a new Asset with updated values', () {
      final updatedAsset = asset.copyWith(name: 'Updated Asset');
      expect(updatedAsset.name, 'Updated Asset');
      expect(updatedAsset.id, asset.id);
    });
  });
}
