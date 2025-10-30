import 'package:flutter/cupertino.dart';

class BranchModel {
  final String name;
  final String address;
  final String managerName;
  final String managerPhone;
  final int deliveryVolume;
  final List<String> recyclableTypes;
  final String deliverySchedule;

  const BranchModel({
    required this.name,
    required this.address,
    required this.managerName,
    required this.managerPhone,
    required this.deliveryVolume,
    required this.recyclableTypes,
    required this.deliverySchedule,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      managerName: json['managerName'] ?? '',
      managerPhone: json['managerPhone'] ?? '',
      deliveryVolume: json['deliveryVolume'] ?? 0,
      recyclableTypes: (json['recyclableTypes'] as List?)
          ?.map((type) => type.toString())
          .toList() ??
          [],
      deliverySchedule: json['deliverySchedule'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'managerName': managerName,
      'managerPhone': managerPhone,
      'deliveryVolume': deliveryVolume,
      'recyclableTypes': recyclableTypes,
      'deliverySchedule': deliverySchedule,
    };
  }

  BranchModel copyWith({
    String? name,
    String? address,
    String? managerName,
    String? managerPhone,
    int? deliveryVolume,
    List<String>? recyclableTypes,
    String? deliverySchedule,
  }) {
    return BranchModel(
      name: name ?? this.name,
      address: address ?? this.address,
      managerName: managerName ?? this.managerName,
      managerPhone: managerPhone ?? this.managerPhone,
      deliveryVolume: deliveryVolume ?? this.deliveryVolume,
      recyclableTypes: recyclableTypes ?? this.recyclableTypes,
      deliverySchedule: deliverySchedule ?? this.deliverySchedule,
    );
  }
}

class TraderProfileData {
  final String name;
  final String activityType;
  final String address;
  final String responsiblePerson;
  final String phoneNumber;
  final String email;
  final int requiredProducts;
  final int availableProducts;
  final List<BranchModel> branches; // بدل branchCount
  final List<String> recyclableTypes; // الأنواع المتعامل بها
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
    required this.branches,
    required this.recyclableTypes,
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
      branches: (json['branches'] as List?)
          ?.map((branchJson) => BranchModel.fromJson(branchJson))
          .toList() ??
          [],
      recyclableTypes: (json['recyclableTypes'] as List?)
          ?.map((type) => type.toString())
          .toList() ??
          [],
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
      'branches': branches.map((branch) => branch.toJson()).toList(),
      'recyclableTypes': recyclableTypes,
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
    List<BranchModel>? branches,
    List<String>? recyclableTypes,
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
      branches: branches ?? this.branches,
      recyclableTypes: recyclableTypes ?? this.recyclableTypes,
      logoPath: logoPath ?? this.logoPath,
    );
  }

  int get branchCount => branches.length;
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