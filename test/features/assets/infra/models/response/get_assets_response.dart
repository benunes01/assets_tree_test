import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_test/features/assets/infra/models/asset_model.dart';
import 'package:tractian_test/features/assets/infra/models/location_model.dart';
import 'package:tractian_test/features/assets/infra/models/response/get_assets_response.dart';
import 'dart:convert';

void main() {
  group('GetAssetsResponse Model', () {
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

    final response = GetAssetsResponse(
      locations: [location],
      assets: [asset],
    );

    test('toMap returns correct map', () {
      final map = response.toMap();
      expect(map, {
        'locations': [
          {
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

    test('fromMap creates correct GetAssetsResponse', () {
      final map = {
        'locations': [
          {
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
      final responseFromMap = GetAssetsResponse.fromMap(map);
      expect(responseFromMap.locations.length, response.locations.length);
      expect(responseFromMap.assets.length, response.assets.length);
      expect(responseFromMap.locations[0].name, response.locations[0].name);
      expect(responseFromMap.assets[0].name, response.assets[0].name);
    });

    test('toJson returns correct JSON string', () {
      final jsonStr = response.toJson();
      expect(jsonStr, json.encode(response.toMap()));
    });

    test('fromJson creates correct GetAssetsResponse', () {
      final jsonStr = json.encode(response.toMap());
      final responseFromJson = GetAssetsResponse.fromJson(jsonStr);
      expect(responseFromJson.locations.length, response.locations.length);
      expect(responseFromJson.assets.length, response.assets.length);
      expect(responseFromJson.locations[0].name, response.locations[0].name);
      expect(responseFromJson.assets[0].name, response.assets[0].name);
    });

    test('copyWith creates a new GetAssetsResponse with updated values', () {
      final updatedResponse = response.copyWith(
        locations: [response.locations[0]],
        assets: [response.assets[0]],
      );
      expect(updatedResponse.locations.length, response.locations.length);
      expect(updatedResponse.assets.length, response.assets.length);
      expect(updatedResponse.locations[0].name, response.locations[0].name);
      expect(updatedResponse.assets[0].name, response.assets[0].name);
    });
  });
}
