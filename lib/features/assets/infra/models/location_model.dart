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
      parentId: map['parentId']
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
