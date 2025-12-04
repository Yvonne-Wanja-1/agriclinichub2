class CropCalendarEntry {
  final String county;
  final String cropName;
  final String season;
  final DateTime plantingStart;
  final DateTime plantingEnd;
  final DateTime harvestStart;
  final DateTime harvestEnd;
  final List<String> seasonalTips;
  final List<String> requiredInputs;

  CropCalendarEntry({
    required this.county,
    required this.cropName,
    required this.season,
    required this.plantingStart,
    required this.plantingEnd,
    required this.harvestStart,
    required this.harvestEnd,
    required this.seasonalTips,
    required this.requiredInputs,
  });

  Map<String, dynamic> toMap() {
    return {
      'county': county,
      'cropName': cropName,
      'season': season,
      'plantingStart': plantingStart.toIso8601String(),
      'plantingEnd': plantingEnd.toIso8601String(),
      'harvestStart': harvestStart.toIso8601String(),
      'harvestEnd': harvestEnd.toIso8601String(),
      'seasonalTips': seasonalTips,
      'requiredInputs': requiredInputs,
    };
  }

  factory CropCalendarEntry.fromMap(Map<String, dynamic> map) {
    return CropCalendarEntry(
      county: map['county'] ?? '',
      cropName: map['cropName'] ?? '',
      season: map['season'] ?? '',
      plantingStart: map['plantingStart'] != null
          ? DateTime.parse(map['plantingStart'])
          : DateTime.now(),
      plantingEnd: map['plantingEnd'] != null
          ? DateTime.parse(map['plantingEnd'])
          : DateTime.now(),
      harvestStart: map['harvestStart'] != null
          ? DateTime.parse(map['harvestStart'])
          : DateTime.now(),
      harvestEnd: map['harvestEnd'] != null
          ? DateTime.parse(map['harvestEnd'])
          : DateTime.now(),
      seasonalTips: List<String>.from(map['seasonalTips'] ?? []),
      requiredInputs: List<String>.from(map['requiredInputs'] ?? []),
    );
  }
}
