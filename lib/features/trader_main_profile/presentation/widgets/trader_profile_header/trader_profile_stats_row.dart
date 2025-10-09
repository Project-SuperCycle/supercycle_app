import 'package:flutter/material.dart';
import 'package:supercycle_app/features/trader_main_profile/data/models/trader_profile_data.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_header/trader_profile_stats_column.dart';

class TraderProfileStatsRow extends StatelessWidget {
  const TraderProfileStatsRow({
    super.key,
    required this.profileData,
    this.profileImage,
  });

  final TraderProfileData profileData;
  final Widget? profileImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Stat - Required Shipments
        Expanded(
          child: TraderProfileStatsColumn(
            number: profileData.requiredProducts.toString().padLeft(2, '0'),
            label: 'عدد الشحنات\nالمطلوبة',
          ),
        ),
        const SizedBox(width: 12),
        // Center - trader_main_profile Image
        if (profileImage != null) profileImage!,

        const SizedBox(width: 12),
        // Right Stat - Available Shipments
        Expanded(
          child: TraderProfileStatsColumn(
            number: profileData.availableProducts.toString().padLeft(2, '0'),
            label: 'عدد الشحنات\nالمتفق عليها',
          ),
        ),
      ],
    );
  }
}
