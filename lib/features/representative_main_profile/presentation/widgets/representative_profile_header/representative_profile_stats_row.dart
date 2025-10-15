import 'package:flutter/material.dart';
import 'package:supercycle_app/features/representative_main_profile/data/models/representative_profile_data.dart';
import 'package:supercycle_app/features/representative_main_profile/presentation/widgets/representative_profile_header/representative_profile_stats_column.dart';

class RepresentativeProfileStatsRow extends StatelessWidget {
  const RepresentativeProfileStatsRow({
    super.key,
    required this.profileData,
    this.profileImage,
  });

  final RepresentativeProfileData profileData;
  final Widget? profileImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Stat - Required Shipments
        Expanded(
          child: RepresentativeProfileStatsColumn(
            number: profileData.requiredProducts.toString().padLeft(2, '0'),
            label: 'عدد شحناتك\nمعانا',
          ),
        ),
        const SizedBox(width: 12),
        // Center - representative_main_profile Image
        if (profileImage != null) profileImage!,

        const SizedBox(width: 12),
        // Right Stat - Available Shipments
        Expanded(
          child: RepresentativeProfileStatsColumn(
            number: profileData.weeklyProducts.toString().padLeft(2, '0'),
            label: 'عدد شحنات\nالاسبوع ده',
          ),
        ),
      ],
    );
  }
}
