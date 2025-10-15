import 'package:flutter/cupertino.dart';

class RepresentativeProfileData {
  final String name;
  final String phoneNumber;
  final String email;
  final int requiredProducts;
  final int weeklyProducts;
  final String logoPath;

  const RepresentativeProfileData({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.requiredProducts,
    required this.weeklyProducts,
    required this.logoPath,
  });

  factory RepresentativeProfileData.fromJson(Map<String, dynamic> json) {
    return RepresentativeProfileData(
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      requiredProducts: json['requiredProducts'] ?? 0,
      weeklyProducts: json['availableProducts'] ?? 0,
      logoPath: json['logoPath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'requiredProducts': requiredProducts,
      'availableProducts': weeklyProducts,
      'logoPath': logoPath,
    };
  }

  RepresentativeProfileData copyWith({
    String? name,
    String? phoneNumber,
    String? email,
    int? requiredProducts,
    int? availableProducts,
    String? logoPath,
  }) {
    return RepresentativeProfileData(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      requiredProducts: requiredProducts ?? this.requiredProducts,
      weeklyProducts: availableProducts ?? this.weeklyProducts,
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
