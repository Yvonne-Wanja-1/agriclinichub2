class FarmerProfile {
  final String userId;
  final String fullName;
  final String phone;
  final String county;
  final double farmSize;
  final List<String> cropTypes;
  final List<String> livestockTypes;
  final DateTime createdAt;
  final DateTime updatedAt;

  FarmerProfile({
    required this.userId,
    required this.fullName,
    required this.phone,
    required this.county,
    required this.farmSize,
    required this.cropTypes,
    required this.livestockTypes,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullName': fullName,
      'phone': phone,
      'county': county,
      'farmSize': farmSize,
      'cropTypes': cropTypes,
      'livestockTypes': livestockTypes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory FarmerProfile.fromMap(Map<String, dynamic> map) {
    return FarmerProfile(
      userId: map['userId'] ?? '',
      fullName: map['fullName'] ?? '',
      phone: map['phone'] ?? '',
      county: map['county'] ?? '',
      farmSize: (map['farmSize'] ?? 0).toDouble(),
      cropTypes: List<String>.from(map['cropTypes'] ?? []),
      livestockTypes: List<String>.from(map['livestockTypes'] ?? []),
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : DateTime.now(),
    );
  }
}
