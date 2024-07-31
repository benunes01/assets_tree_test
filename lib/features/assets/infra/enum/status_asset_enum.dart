enum StatusAsset {
  alert,
  operating,
}

extension StatusAssetExtension on StatusAsset {
  String toShortString() {
    switch (this) {
      case StatusAsset.alert:
        return 'alert';
      case StatusAsset.operating:
        return 'operating';
      default:
        return '';
    }
  }

  static StatusAsset? fromString(String? status) {
    switch (status) {
      case 'alert':
        return StatusAsset.alert;
      case 'operating':
        return StatusAsset.operating;
      default:
        return null;
    }
  }

  static bool isCritic(String? status) {
    return status == 'alert';
  }
}