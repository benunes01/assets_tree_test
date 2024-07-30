import 'dart:convert';

import 'package:tractian_test/features/assets/infra/models/asset_model.dart';

class Location {
  final String name;
  final String id;
  final String? parentId;
  List<Location> subLocations = [];
  List<Asset> assets = [];
  bool isExpanded = false;

  Location({
    required this.name,
    required this.id,
    this.parentId,
    this.subLocations = const [],
    this.assets = const []
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'parentId': parentId,
      'subLocations': subLocations.map((subLocation) => subLocation.toMap()).toList(),
      'assets': assets.map((asset) => asset.toMap()).toList(),
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      name: map['name'],
      id: map['id'],
      parentId: map['parentId'],
      subLocations: map['subLocations'] == null
          ? []
          : (map['subLocations'] as List<dynamic>)
          .map((childMap) => Location.fromMap(childMap as Map<String, dynamic>))
          .toList(),
      assets: map['assets'] == null
          ? []
          : (map['assets'] as List<dynamic>)
          .map((childMap) => Asset.fromMap(childMap as Map<String, dynamic>))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) => Location.fromMap(json.decode(source));

  Location copyWith({
    String? name,
    String? id,
    String? parentId,
    List<Location>? subLocations,
    List<Asset>? assets,
  }) {
    return Location(
      name: name ?? this.name,
      id: id ?? this.id,
      parentId: parentId ?? this.parentId
    );
  }
}
