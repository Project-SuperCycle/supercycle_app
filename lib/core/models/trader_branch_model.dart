class TraderBranchModel {
  // Main Branch
  final String? branchName;
  final String? address;
  final String? contactName;
  final String? contactPhone;
  final DateTime? startDate;

  TraderBranchModel({
    required this.branchName,
    required this.address,
    required this.contactName,
    required this.contactPhone,
    required this.startDate,
  });

  // Factory constructor for creating a new instance from a map (JSON)
  factory TraderBranchModel.fromJson(Map<String, dynamic> json) {
    return TraderBranchModel(
      branchName: json['branchName'],
      address: json['address'],
      contactName: json['contactName'],
      contactPhone: json['contactPhone'],
      startDate: DateTime.parse(json['createdAt']),
    );
  }

  // CopyWith method for creating a new instance with updated values
  TraderBranchModel copyWith({
    String? branchName,
    String? address,
    String? contactName,
    String? contactPhone,
    DateTime? startDate,
  }) {
    return TraderBranchModel(
      branchName: branchName ?? this.branchName,
      address: address ?? this.address,
      contactName: contactName ?? this.contactName,
      contactPhone: contactPhone ?? this.contactPhone,
      startDate: startDate ?? this.startDate,
    );
  }
}
