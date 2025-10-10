import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';

class SegmentDeliverdSection extends StatelessWidget {
  const SegmentDeliverdSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEDB2).withAlpha(100),
        borderRadius: BorderRadius.circular(20),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Destination details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  bottom: 12.0,
                  right: 5.0,
                  left: 12.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "تم التسليم",
                      style: AppStyles.styleBold12(context),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.check_circle_outline_rounded,
                      size: 25,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            SvgPicture.asset(
              AppAssets.rectangleBorder2,
              fit: BoxFit.fill,
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
