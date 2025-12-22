class TraderBranchModel {
  final String branchId;
  final String branchName;
  final String address;
  final String contactName;
  final String contactPhone;
  final int deliveryVolume;
  final List<String> recyclableTypes;
  final String deliverySchedule;

  const TraderBranchModel({
    required this.branchId,
    required this.branchName,
    required this.address,
    required this.contactName,
    required this.contactPhone,
    required this.deliveryVolume,
    required this.recyclableTypes,
    required this.deliverySchedule,
  });

  factory TraderBranchModel.fromJson(Map<String, dynamic> json) {
    return TraderBranchModel(
      branchId: json['_id'] ?? '',
      branchName: json['branchName'] ?? '',
      address: json['address'] ?? '',
      contactName: json['contactName'] ?? '',
      contactPhone: json['contactPhone'] ?? '',
      deliveryVolume: json['deliveryVolume'] ?? 0,
      recyclableTypes: (json['recyclableTypes'] != null)
          ? (json['recyclableTypes'] as List)
                .map((type) => type.toString())
                .toList()
          : [],
      deliverySchedule: json['deliverySchedule'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': branchId,
      'branchName': branchName,
      'address': address,
      'contactName': contactName,
      'contactPhone': contactPhone,
      'deliveryVolume': deliveryVolume,
      'recyclableTypes': recyclableTypes,
      'deliverySchedule': deliverySchedule,
    };
  }

  @override
  String toString() {
    return 'TraderBranchModel(branchId: $branchId, branchName: $branchName, address: $address, contactName: $contactName, contactPhone: $contactPhone, deliveryVolume: $deliveryVolume, recyclableTypes: $recyclableTypes, deliverySchedule: $deliverySchedule)';
  }

  TraderBranchModel copyWith({
    String? branchId,
    String? branchName,
    String? address,
    String? contactName,
    String? contactPhone,
    int? deliveryVolume,
    List<String>? recyclableTypes,
    String? deliverySchedule,
  }) {
    return TraderBranchModel(
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      address: address ?? this.address,
      contactName: contactName ?? this.contactName,
      contactPhone: contactPhone ?? this.contactPhone,
      deliveryVolume: deliveryVolume ?? this.deliveryVolume,
      recyclableTypes: recyclableTypes ?? this.recyclableTypes,
      deliverySchedule: deliverySchedule ?? this.deliverySchedule,
    );
  }
}
