import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/helpers/custom_back_button.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/app_styles.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/features/trader_main_profile/data/models/trader_profile_data.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key, required this.profileData});

  final TraderProfileData profileData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: kGradientContainer,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Header Navigation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Menu Button (Opens Drawer)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 24,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
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
                              const SizedBox(width: 5),
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
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CustomBackButton(
                          color: Colors.white,
                          size: 24,
                          onPressed: () {
                            GoRouter.of(context).go(EndPoints.homeView);
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Profile Image
                  Container(
                    width: ProfileConstants.profileImageSize,
                    height: ProfileConstants.profileImageSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
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
                              color: Color(0xFF10B981),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Profile Name
                  Text(
                    profileData.name,
                    style: AppStyles.styleBold24(context).copyWith(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Stats Row
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(20),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatCard(
                          value: profileData.availableProducts
                              .toString()
                              .padLeft(2, '0'),
                          label: 'المنتجات\nالمتاحة',
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.white.withAlpha(80),
                        ),
                        _StatCard(
                          value: profileData.requiredProducts
                              .toString()
                              .padLeft(2, '0'),
                          label: 'المنتجات\nالمطلوبة',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppStyles.styleBold24(context).copyWith(
            color: Colors.white,
            fontSize: 32,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppStyles.styleSemiBold12(
            context,
          ).copyWith(color: const Color(0xFFD1FAE5)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}