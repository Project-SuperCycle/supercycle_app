import 'package:flutter/material.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_stats_column.dart';
import 'package:supercycle_app/features/representative_profile/presentation/widgets/representativ_profile_image.dart';
import 'package:supercycle_app/features/representative_profile/presentation/widgets/representative_profile_data.dart';

class RepresentativeProfileStatsRow extends StatelessWidget {
  const RepresentativeProfileStatsRow({
    super.key,
    required this.representativeProfileData,
  });

  final RepresentativeProfileData representativeProfileData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Stat - Total Shipments
        ProfileStatsColumn(
          number: representativeProfileData.totalShipments.toString().padLeft(2, '0'),
          label: 'عدد شحناتك\nمعنا',
        ),

        // Profile Image
        RepresentativProfileImage(logoPath: representativeProfileData.logoPath),

        // Right Stat - Weekly Shipments
        ProfileStatsColumn(
          number: representativeProfileData.weeklyShipments.toString().padLeft(2, '0'),
          label: 'عدد الشحنات\nالأسبوع ده',
        ),
      ],
    );
  }
}