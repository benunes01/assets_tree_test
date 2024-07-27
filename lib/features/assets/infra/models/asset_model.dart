import 'dart:convert';

class Asset {
  final String name;
  final String id;
  final String? locationId;
  final String? parentId;
  final String? sensorType;
  final String? status;
  List<Asset> children = [];
  bool isExpanded = false;

  Asset({
    required this.name,
    required this.id,
    this.locationId,
    this.parentId,
    this.sensorType,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'locationId': locationId,
      'parentId': parentId,
      'sensorType': sensorType,
      'status': status,
      'children': children.map((child) => child.toMap()).toList(),
    };
  }

  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      name: map['name'],
      id: map['id'],
      locationId: map['locationId'],
      parentId: map['parentId'],
      sensorType: map['sensorType'],
      status: map['status']
    );
  }

  String toJson() => json.encode(toMap());

  factory Asset.fromJson(String source) => Asset.fromMap(json.decode(source));

  Asset copyWith({
    String? name,
    String? id,
    String? locationId,
    String? parentId,
    String? sensorType,
    String? status,
    List<Asset>? children,
  }) {
    return Asset(
      name: name ?? this.name,
      id: id ?? this.id,
      locationId: locationId ?? this.locationId,
      parentId: parentId ?? this.parentId,
      sensorType: sensorType ?? this.sensorType,
      status: status ?? this.status,
    );
  }
}
