import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_header/trader_profile_header_section.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_info_card1.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_info_card2.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_info_card3.dart';
import 'package:supercycle_app/features/trader_main_profile/presentation/widgets/trader_profile_page_indicator.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Profile Header Section
          ProfileHeaderSection(profileData: ProfileConstants.sampleProfileData),
          const SizedBox(height: 20),

          // Page Indicators
          TraderProfilePageIndicator(
            currentPage: currentPage,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
          ),

          const SizedBox(height: 10),

          // White Content Section with different cards based on currentPage
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 2),
                    _buildCurrentPageContent(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPageContent() {
    switch (currentPage) {
      case 0:
        return TraderProfileInfoCard1(
          profileData: ProfileConstants.sampleProfileData,
        );
      case 1:
        return const TraderProfileInfoCard2();
      case 2:
        return const TraderProfileInfoCard3();
      default:
        return TraderProfileInfoCard1(
          profileData: ProfileConstants.sampleProfileData,
        );
    }
  }
}
