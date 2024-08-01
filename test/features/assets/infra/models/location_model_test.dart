import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_test/features/assets/infra/models/asset_model.dart';
import 'package:tractian_test/features/assets/infra/models/location_model.dart';
import 'dart:convert';

void main() {
  group('Location Model', () {
    final asset = Asset(
      name: 'Asset 1',
      id: '1',
    );

    final location = Location(
      name: 'Location 1',
      id: 'loc1',
      parentId: 'parent1',
      subLocations: [
        Location(
          name: 'Sub Location 1',
          id: 'sub1',
        ),
      ],
      assets: [asset],
    );

    test('toMap returns correct map', () {
      final map = location.toMap();
      expect(map, {
        'name': 'Location 1',
        'id': 'loc1',
        'parentId': 'parent1',
        'subLocations': [
          {
            'name': 'Sub Location 1',
            'id': 'sub1',
            'parentId': null,
            'subLocations': [],
            'assets': []
          }
        ],
        'assets': [
          {
            'name': 'Asset 1',
            'id': '1',
            'locationId': null,
            'parentId': null,
            'sensorType': null,
            'status': null,
            'children': []
          }
        ],
      });
    });

    test('fromMap creates correct Location', () {
      final map = {
        'name': 'Location 1',
        'id': 'loc1',
        'parentId': 'parent1',
        'subLocations': [
          {
            'name': 'Sub Location 1',
            'id': 'sub1',
            'parentId': null,
            'subLocations': [],
            'assets': []
          }
        ],
        'assets': [
          {
            'name': 'Asset 1',
            'id': '1',
            'locationId': null,
            'parentId': null,
            'sensorType': null,
            'status': null,
            'children': []
          }
        ],
      };
      final locationFromMap = Location.fromMap(map);
      expect(locationFromMap.name, location.name);
      expect(locationFromMap.id, location.id);
      expect(locationFromMap.parentId, location.parentId);
      expect(locationFromMap.subLocations.length, location.subLocations.length);
      expect(locationFromMap.assets.length, location.assets.length);
      expect(locationFromMap.subLocations[0].name, location.subLocations[0].name);
      expect(locationFromMap.assets[0].name, location.assets[0].name);
    });

    test('toJson returns correct JSON string', () {
      final jsonStr = location.toJson();
      expect(jsonStr, json.encode(location.toMap()));
    });

    test('fromJson creates correct Location', () {
      final jsonStr = json.encode(location.toMap());
      final locationFromJson = Location.fromJson(jsonStr);
      expect(locationFromJson.name, location.name);
      expect(locationFromJson.id, location.id);
      expect(locationFromJson.parentId, location.parentId);
      expect(locationFromJson.subLocations.length, location.subLocations.length);
      expect(locationFromJson.assets.length, location.assets.length);
      expect(locationFromJson.subLocations[0].name, location.subLocations[0].name);
      expect(locationFromJson.assets[0].name, location.assets[0].name);
    });

    test('copyWith creates a new Location with updated values', () {
      final updatedLocation = location.copyWith(name: 'Updated Location');
      expect(updatedLocation.name, 'Updated Location');
      expect(updatedLocation.id, location.id);
    });
  });
}
