import 'package:flutter/material.dart';
import 'package:supercycle_app/core/constants.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_data.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_header/profile_header_navigation.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_image.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({
    super.key,
    required this.profileData,
  });

  final ProfileData profileData;

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
                    const ProfileHeaderNavigation(),

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
              child: ProfileImage(
                logoPath: profileData.logoPath,
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
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
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
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
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