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

  static SensorType fromString(String sensorType) {
    switch (sensorType) {
      case 'energy':
        return SensorType.energy;
      case 'vibration':
        return SensorType.vibration;
      default:
        throw ArgumentError('Tipo de sensor desconhecido: $sensorType');
    }
  }
}