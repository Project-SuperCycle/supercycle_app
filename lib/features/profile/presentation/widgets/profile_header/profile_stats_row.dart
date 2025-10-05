import 'package:flutter/material.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_data.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_header/profile_stats_column.dart';

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({
    super.key,
    required this.profileData,
    this.profileImage,
  });

  final ProfileData profileData;
  final Widget? profileImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Stat - Required Shipments
        Expanded(
          child: ProfileStatsColumn(
            number: profileData.requiredProducts.toString().padLeft(2, '0'),
            label: 'عدد الشحنات\nالمطلوبة',
          ),
        ),
        const SizedBox(width: 12),
        // Center - Profile Image
        if (profileImage != null) profileImage!,

        const SizedBox(width: 12),
        // Right Stat - Available Shipments
        Expanded(
          child: ProfileStatsColumn(
            number: profileData.availableProducts.toString().padLeft(2, '0'),
            label: 'عدد الشحنات\nالمتفق عليها',
          ),
        ),
      ],
    );
  }
}
