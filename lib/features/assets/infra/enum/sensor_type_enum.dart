import 'package:flutter/material.dart';

enum SensorType {
  energy,
  vibration,
}

extension SensorTypeExtension on SensorType {
  String toShortString() {
    switch (this) {
      case SensorType.energy:
        return 'energy';
      case SensorType.vibration:
        return 'vibration';
      default:
        return '';
    }
  }

  static SensorType? fromString(String? sensorType) {
    switch (sensorType) {
      case 'energy':
        return SensorType.energy;
      case 'vibration':
        return SensorType.vibration;
      default:
        return null;
    }
  }

  IconData getIcon() {
    switch (this) {
      case SensorType.energy:
        return Icons.flash_on;
      case SensorType.vibration:
        return Icons.vibration;
      default:
        return Icons.insert_emoticon;
    }
  }
}