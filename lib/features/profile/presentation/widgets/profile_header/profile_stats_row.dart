import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_data.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_stats_column.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_image.dart';

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({
    super.key,
    required this.profileData,
  });

  final ProfileData profileData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Stat - Required Shipments
        ProfileStatsColumn(
          number: profileData.requiredProducts.toString().padLeft(2, '0'),
          label: 'عدد الشحنات\nالمطلوبة',
        ),

        // Profile Image - Positioned to overlap
        ProfileImage(logoPath: profileData.logoPath),

        // Right Stat - Available Shipments
        ProfileStatsColumn(
          number: profileData.availableProducts.toString().padLeft(2, '0'),
          label: 'عدد الشحنات\nالمتفق عليها',
        ),
      ],
    );
  }
}