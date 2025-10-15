import 'package:flutter/cupertino.dart';

class TraderProfileData {
  final String name;
  final String activityType;
  final String address;
  final String responsiblePerson;
  final String phoneNumber;
  final String email;
  final int requiredProducts;
  final int availableProducts;
  final int branchCount;
  final String logoPath;

  const TraderProfileData({
    required this.name,
    required this.activityType,
    required this.address,
    required this.responsiblePerson,
    required this.phoneNumber,
    required this.email,
    required this.requiredProducts,
    required this.availableProducts,
    required this.branchCount,
    required this.logoPath,
  });

  factory TraderProfileData.fromJson(Map<String, dynamic> json) {
    return TraderProfileData(
      name: json['name'] ?? '',
      activityType: json['activityType'] ?? '',
      address: json['address'] ?? '',
      responsiblePerson: json['responsiblePerson'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      requiredProducts: json['requiredProducts'] ?? 0,
      availableProducts: json['availableProducts'] ?? 0,
      branchCount: json['branchCount'] ?? 0,
      logoPath: json['logoPath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'activityType': activityType,
      'address': address,
      'responsiblePerson': responsiblePerson,
      'phoneNumber': phoneNumber,
      'email': email,
      'requiredProducts': requiredProducts,
      'availableProducts': availableProducts,
      'branchCount': branchCount,
      'logoPath': logoPath,
    };
  }

  TraderProfileData copyWith({
    String? name,
    String? activityType,
    String? address,
    String? responsiblePerson,
    String? phoneNumber,
    String? email,
    int? requiredProducts,
    int? availableProducts,
    int? branchCount,
    String? logoPath,
  }) {
    return TraderProfileData(
      name: name ?? this.name,
      activityType: activityType ?? this.activityType,
      address: address ?? this.address,
      responsiblePerson: responsiblePerson ?? this.responsiblePerson,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      requiredProducts: requiredProducts ?? this.requiredProducts,
      availableProducts: availableProducts ?? this.availableProducts,
      branchCount: branchCount ?? this.branchCount,
      logoPath: logoPath ?? this.logoPath,
    );
  }
}

class ProfileInfoItem {
  final String label;
  final String value;
  final IconData icon;

  const ProfileInfoItem({
    required this.label,
    required this.value,
    required this.icon,
  });
}
