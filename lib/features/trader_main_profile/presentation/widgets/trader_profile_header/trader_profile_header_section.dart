import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/core/helpers/custom_back_button.dart';
import 'package:supercycle_app/core/routes/end_points.dart';
import 'package:supercycle_app/core/utils/app_assets.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/features/trader_main_profile/data/models/trader_profile_data.dart';

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
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: const BoxDecoration(
                gradient: kGradientContainer,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 20),

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
                    const Spacer(),

                    Text(
                      profileData.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: -60,
              child: Container(
                width: ProfileConstants.profileImageSize,
                height: ProfileConstants.profileImageSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF4CAF50), width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
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

        const SizedBox(height: 30),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    profileData.availableProducts.toString().padLeft(2, '0'),
                    style: const TextStyle(
                      color: Color(0xFF4CAF50),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'المنتجات\nالمتاحة',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ],
              ),

              Column(
                children: [
                  Text(
                    profileData.requiredProducts.toString().padLeft(2, '0'),
                    style: const TextStyle(
                      color: Color(0xFF4CAF50),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'المنتجات\nالمطلوبة',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
