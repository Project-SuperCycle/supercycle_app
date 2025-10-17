import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/trader_main_profile/data/models/trader_profile_data.dart';

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
      children: [
        Column(
          children: [
            Text(
              profileData.availableProducts.toString().padLeft(2, '0'),
              style: AppStyles.styleBold24(
                context,
              ).copyWith(color: AppColors.primaryColor, fontSize: 32),
            ),
            const SizedBox(height: 5),
            Text(
              'المنتجات\nالمتاحة',
              textAlign: TextAlign.center,
              style: AppStyles.styleSemiBold14(context),
            ),
          ],
        ),

        Column(
          children: [
            Text(
              profileData.requiredProducts.toString().padLeft(2, '0'),
              style: AppStyles.styleBold24(
                context,
              ).copyWith(color: AppColors.primaryColor, fontSize: 32),
            ),
            const SizedBox(height: 5),
            Text(
              'المنتجات\nالمطلوبة',
              textAlign: TextAlign.center,
              style: AppStyles.styleSemiBold14(context),
            ),
          ],
        ),
      ],
    );
  }
}
