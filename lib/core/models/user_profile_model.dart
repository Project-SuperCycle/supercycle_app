class UserProfileModel {
  // Basic Info
  final String email;
  final String role;

  // Profile
  final String? businessName;
  final String? rawBusinessType;
  final String? businessAddress;
  final String? doshManagerName;
  final String? doshManagerPhone;

  // Main Branch
  final String? branchName;
  final String? address;
  final String? contactName;
  final String? contactPhone;
  final DateTime? createdAt;

  // Stats
  final num? totalShipmentsCount;
  final num? fullyDeliveredCount;
  final num? partiallyDeliveredCount;
  final num? totalShipments;
  final num? delivered;
  final num? failed;

  // Representative
  final String? repPhone;
  final String? repEmail;
  final String? repName;

  UserProfileModel({
    required this.email,
    required this.role,
    required this.businessName,
    required this.rawBusinessType,
    required this.businessAddress,
    required this.doshManagerName,
    required this.doshManagerPhone,
    required this.branchName,
    required this.address,
    required this.contactName,
    required this.contactPhone,
    required this.createdAt,
    required this.totalShipmentsCount,
    required this.fullyDeliveredCount,
    required this.partiallyDeliveredCount,
    required this.totalShipments,
    required this.delivered,
    required this.failed,
    required this.repPhone,
    required this.repEmail,
    required this.repName,
  });

  // Factory constructor for creating a new instance from a map (JSON)
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      email: json['basicInfo']['email'] ?? '',
      role: json['basicInfo']['role'] ?? '',
      businessName: (json['profile'] != null)
          ? json['profile']['bussinessName']
          : null,
      rawBusinessType: (json['profile'] != null)
          ? json['profile']['rawBusinessType']
          : null,
      businessAddress: (json['profile'] != null)
          ? json['profile']['bussinessAdress']
          : null,
      doshManagerName: (json['profile'] != null)
          ? json['profile']['doshMangerName']
          : null,
      doshManagerPhone: (json['profile'] != null)
          ? json['profile']['doshMangerPhone']
          : null,
      branchName: (json['mainBranch'] != null)
          ? json['mainBranch']['branchName']
          : null,
      address: (json['mainBranch'] != null)
          ? json['mainBranch']['address']
          : null,
      contactName: (json['mainBranch'] != null)
          ? json['mainBranch']['contactName']
          : null,
      contactPhone: (json['mainBranch'] != null)
          ? json['mainBranch']['contactPhone']
          : null,
      createdAt: (json['mainBranch'] != null)
          ? DateTime.parse(json['mainBranch']['createdAt'])
          : null,
      totalShipmentsCount: (json['stats'] != null)
          ? json['stats']['totalShipmentsCount']
          : null,
      fullyDeliveredCount: (json['stats'] != null)
          ? json['stats']['fullyDeliveredCount']
          : null,
      partiallyDeliveredCount: (json['stats'] != null)
          ? json['stats']['partiallyOrFullyDeliveredCount']
          : null,
      totalShipments: (json['stats'] != null)
          ? json['stats']['totalShipments']
          : null,
      delivered: (json['stats'] != null) ? json['stats']['delivered'] : null,
      failed: (json['stats'] != null) ? json['stats']['failed'] : null,
      repPhone: (json['representative'] != null)
          ? json['representative']['phone']
          : null,
      repEmail: (json['representative'] != null)
          ? json['representative']['email']
          : null,
      repName: (json['representative'] != null)
          ? json['representative']['displayName']
          : null,
    );
  }

  // CopyWith method for creating a new instance with updated values
  UserProfileModel copyWith({
    String? email,
    String? role,
    String? businessName,
    String? rawBusinessType,
    String? businessAddress,
    String? doshManagerName,
    String? doshManagerPhone,
    String? branchName,
    String? address,
    String? contactName,
    String? contactPhone,
    DateTime? createdAt,
    num? totalShipmentsCount,
    num? fullyDeliveredCount,
    num? partiallyDeliveredCount,
    num? totalShipments,
    num? delivered,
    num? failed,
    String? repPhone,
    String? repEmail,
    String? repName,
  }) {
    return UserProfileModel(
      email: email ?? this.email,
      role: role ?? this.role,
      businessName: businessName ?? this.businessName,
      rawBusinessType: rawBusinessType ?? this.rawBusinessType,
      businessAddress: businessAddress ?? this.businessAddress,
      doshManagerName: doshManagerName ?? this.doshManagerName,
      doshManagerPhone: doshManagerPhone ?? this.doshManagerPhone,
      branchName: branchName ?? this.branchName,
      address: address ?? this.address,
      contactName: contactName ?? this.contactName,
      contactPhone: contactPhone ?? this.contactPhone,
      createdAt: createdAt ?? this.createdAt,
      totalShipmentsCount: totalShipmentsCount ?? this.totalShipmentsCount,
      fullyDeliveredCount: fullyDeliveredCount ?? this.fullyDeliveredCount,
      partiallyDeliveredCount:
          partiallyDeliveredCount ?? this.partiallyDeliveredCount,
      totalShipments: totalShipments ?? this.totalShipments,
      delivered: delivered ?? this.delivered,
      failed: failed ?? this.failed,
      repPhone: repPhone ?? this.repPhone,
      repEmail: repEmail ?? this.repEmail,
      repName: repName ?? this.repName,
    );
  }
}
