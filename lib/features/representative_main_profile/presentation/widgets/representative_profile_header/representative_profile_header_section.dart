import 'package:flutter/material.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/features/representative_main_profile/data/models/representative_profile_data.dart';
import 'package:supercycle_app/features/representative_main_profile/presentation/widgets/representative_profile_header/representative_profile_header_navigation.dart';
import 'package:supercycle_app/features/representative_main_profile/presentation/widgets/representative_profile_header/representative_profile_stats_row.dart';
import 'package:supercycle_app/features/representative_main_profile/presentation/widgets/representative_profile_image.dart';

class RepresentativeProfileHeaderSection extends StatelessWidget {
  const RepresentativeProfileHeaderSection({
    super.key,
    required this.representativeProfileData,
  });

  final RepresentativeProfileData representativeProfileData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: double.infinity,
              height: 260,
              decoration: const BoxDecoration(
                gradient: kGradientContainer,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  const RepresentativeProfileHeaderNavigation(),
                  const SizedBox(height: 30),
                  Text(
                    representativeProfileData.name,
                    style: AppStyles.styleBold24(
                      context,
                    ).copyWith(color: Colors.white, fontSize: 30),
                  ),
                  const Spacer(),
                ],
              ),
            ),

            Positioned(
              bottom: -60,
              child: RepresentativProfileImage(
                logoPath: representativeProfileData.logoPath,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.10,
          ),
          child: RepresentativeProfileStatsRow(
            representativeProfileData: representativeProfileData,
          ),
        ),

        const SizedBox(height: 30),

        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(25),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'رقم الهاتف',
                      style: AppStyles.styleSemiBold16(context),
                    ),
                    const SizedBox(height: 5),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        representativeProfileData.phoneNumber,
                        style: AppStyles.styleMedium14(
                          context,
                        ).copyWith(color: Color(0xFF4CAF50)),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 1,
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('الإيميل', style: AppStyles.styleSemiBold16(context)),
                    const SizedBox(height: 5),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        representativeProfileData.email,
                        style: AppStyles.styleMedium14(
                          context,
                        ).copyWith(color: Color(0xFF4CAF50)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}
