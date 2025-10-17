import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/helpers/custom_back_button.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_colors.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/features/trader_main_profile/data/models/trader_profile_data.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_header/trader_profile_stats_row.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key, required this.profileData});

  final TraderProfileData profileData;

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

                  // Header Navigation
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Menu Button (Edit Profile)
                        IconButton(
                          onPressed: () {
                            GoRouter.of(
                              context,
                            ).go(EndPoints.editTraderProfileView);
                          },
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),

                        // Logo Section
                        Expanded(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppAssets.logoName,
                                  fit: BoxFit.contain,
                                  scale: 6.0,
                                ),
                                SizedBox(width: 5),
                                Image.asset(
                                  AppAssets.logoIcon,
                                  fit: BoxFit.contain,
                                  scale: 7.5,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Back Button (Home)
                        CustomBackButton(
                          color: Colors.white,
                          size: 28,
                          onPressed: () {
                            GoRouter.of(context).go(EndPoints.homeView);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    profileData.name,
                    style: AppStyles.styleBold24(
                      context,
                    ).copyWith(color: Colors.white, fontSize: 30),
                  ),
                  const Spacer(),
                ],
              ),
            ),

            Positioned(
              bottom: -50,
              child: Container(
                width: ProfileConstants.profileImageSize,
                height: ProfileConstants.profileImageSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryColor, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 15,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      profileData.logoPath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.store,
                          size: 70,
                          color: Color(0xFF4CAF50),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.15,
          ),
          child: TraderProfileStatsRow(profileData: profileData),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
