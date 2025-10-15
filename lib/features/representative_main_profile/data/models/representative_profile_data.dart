import 'package:flutter/cupertino.dart';

class RepresentativeProfileData {
  final String name;
  final String phoneNumber;
  final String email;
  final String logoPath;
  final int totalShipments;
  final int weeklyShipments;

  const RepresentativeProfileData({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.logoPath,
    this.totalShipments = 0,
    this.weeklyShipments = 0,
  });

  factory RepresentativeProfileData.fromJson(Map<String, dynamic> json) {
    return RepresentativeProfileData(
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      logoPath: json['logoPath'] ?? '',
      totalShipments: json['totalShipments'] ?? 0,
      weeklyShipments: json['weeklyShipments'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'logoPath': logoPath,
      'totalShipments': totalShipments,
      'weeklyShipments': weeklyShipments,
    };
  }

  RepresentativeProfileData copyWith({
    String? name,
    String? phoneNumber,
    String? email,
    String? logoPath,
    int? totalShipments,
    int? weeklyShipments,
  }) {
    return RepresentativeProfileData(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      logoPath: logoPath ?? this.logoPath,
      totalShipments: totalShipments ?? this.totalShipments,
      weeklyShipments: weeklyShipments ?? this.weeklyShipments,
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
