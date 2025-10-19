import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/representative_main_profile/data/models/representative_profile_data.dart';

class RepresentativeProfileStatsRow extends StatelessWidget {
  const RepresentativeProfileStatsRow({
    super.key,
    required this.representativeProfileData,
  });

  final RepresentativeProfileData representativeProfileData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              representativeProfileData.weeklyShipments.toString().padLeft(
                2,
                '0',
              ),
              style: AppStyles.styleBold24(
                context,
              ).copyWith(color: AppColors.primaryColor, fontSize: 32),
            ),
            const SizedBox(height: 5),
            Text(
              'عدد شحناتك\nالأسبوع ده',
              textAlign: TextAlign.center,
              style: AppStyles.styleSemiBold14(context),
            ),
          ],
        ),

        Column(
          children: [
            Text(
              representativeProfileData.totalShipments.toString().padLeft(
                2,
                '0',
              ),
              style: AppStyles.styleBold24(
                context,
              ).copyWith(color: AppColors.primaryColor, fontSize: 32),
            ),
            const SizedBox(height: 5),
            Text(
              'شحنات\nمعنا',
              textAlign: TextAlign.center,
              style: AppStyles.styleSemiBold14(context),
            ),
          ],
        ),
      ],
    );
  }
}
