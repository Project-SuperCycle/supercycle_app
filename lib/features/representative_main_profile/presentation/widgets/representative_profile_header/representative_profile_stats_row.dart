import 'package:flutter/material.dart';
import 'package:supercycle/features/representative_main_profile/data/models/representative_profile_data.dart';
import 'package:supercycle/features/representative_main_profile/presentation/widgets/representative_profile_image.dart';
import 'package:supercycle/features/trader_main_profile/presentation/widgets/trader_profile_header/trader_profile_stats_column.dart';

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
        TraderProfileStatsColumn(
          number: representativeProfileData.totalShipments.toString().padLeft(
            2,
            '0',
          ),
          label: 'عدد شحناتك\nمعنا',
        ),

        // Profile Image
        RepresentativProfileImage(logoPath: representativeProfileData.logoPath),

        // Right Stat - Weekly Shipments
        TraderProfileStatsColumn(
          number: representativeProfileData.weeklyShipments.toString().padLeft(
            2,
            '0',
          ),
          label: 'عدد الشحنات\nالأسبوع ده',
        ),
      ],
    );
  }
}
