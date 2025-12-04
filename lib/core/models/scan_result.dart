class ScanResult {
  final String scanId;
  final String userId;
  final String imagePath;
  final String cropType;
  final List<Disease> detectedDiseases;
  final String healthStatus;
  final DateTime scanDate;
  final double confidence;
  final bool synced;

  ScanResult({
    required this.scanId,
    required this.userId,
    required this.imagePath,
    required this.cropType,
    required this.detectedDiseases,
    required this.healthStatus,
    required this.scanDate,
    required this.confidence,
    this.synced = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'scanId': scanId,
      'userId': userId,
      'imagePath': imagePath,
      'cropType': cropType,
      'detectedDiseases': detectedDiseases.map((d) => d.toMap()).toList(),
      'healthStatus': healthStatus,
      'scanDate': scanDate.toIso8601String(),
      'confidence': confidence,
      'synced': synced,
    };
  }

  factory ScanResult.fromMap(Map<String, dynamic> map) {
    return ScanResult(
      scanId: map['scanId'] ?? '',
      userId: map['userId'] ?? '',
      imagePath: map['imagePath'] ?? '',
      cropType: map['cropType'] ?? '',
      detectedDiseases:
          (map['detectedDiseases'] as List?)
              ?.map((d) => Disease.fromMap(d))
              .toList() ??
          [],
      healthStatus: map['healthStatus'] ?? 'unknown',
      scanDate: map['scanDate'] != null
          ? DateTime.parse(map['scanDate'])
          : DateTime.now(),
      confidence: (map['confidence'] ?? 0).toDouble(),
      synced: map['synced'] ?? false,
    );
  }
}

class Disease {
  final String name;
  final double confidence;
  final String severity;
  final String affectedArea;
  final List<String> treatments;
  final List<String> preventionTips;

  Disease({
    required this.name,
    required this.confidence,
    required this.severity,
    required this.affectedArea,
    required this.treatments,
    required this.preventionTips,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'confidence': confidence,
      'severity': severity,
      'affectedArea': affectedArea,
      'treatments': treatments,
      'preventionTips': preventionTips,
    };
  }

  factory Disease.fromMap(Map<String, dynamic> map) {
    return Disease(
      name: map['name'] ?? '',
      confidence: (map['confidence'] ?? 0).toDouble(),
      severity: map['severity'] ?? 'unknown',
      affectedArea: map['affectedArea'] ?? '',
      treatments: List<String>.from(map['treatments'] ?? []),
      preventionTips: List<String>.from(map['preventionTips'] ?? []),
    );
  }
}
