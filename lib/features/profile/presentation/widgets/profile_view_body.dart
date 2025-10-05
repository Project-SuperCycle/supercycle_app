import 'package:flutter/material.dart';
import 'package:supercycle_app/core/utils/profile_constants.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_header/profile_header_section.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_page_indicator.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_info_card1.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_info_card2.dart';
import 'package:supercycle_app/features/profile/presentation/widgets/profile_info_card3.dart';

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
          ProfileHeaderSection(profileData: ProfileConstants.sampleProfileData),
          const SizedBox(height: 30),
          // Page Indicators
          ProfilePageIndicator(
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  children: [
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
        return ProfileInfoCard1(
          profileData: ProfileConstants.sampleProfileData,
        );
      case 1:
        return const ProfileInfoCard2();
      case 2:
        return const ProfileInfoCard3();
      default:
        return ProfileInfoCard1(
          profileData: ProfileConstants.sampleProfileData,
        );
    }
  }
}
